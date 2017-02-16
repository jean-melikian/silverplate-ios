//
//  ConnectivityManager.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 14/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import Foundation
import ReachabilitySwift
import CoreTelephony

internal class ConnectivityManager {
    
    var reachability: Reachability
    
    init() {
        //declare this property where it won't go out of scope relative to your listener
        reachability = Reachability()!
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityDidChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    func getReachabilityStatus() -> SilverPlate.NetworkState {
        let networkInfo = CTTelephonyNetworkInfo();
        let carrierTypeString = networkInfo.currentRadioAccessTechnology
        var carrierType: SilverPlate.NetworkState = SilverPlate.NetworkState.none
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
                carrierType = SilverPlate.NetworkState.wifi
                
            } else if reachability.isReachableViaWWAN {
                print("Reachable via Cellular")
                switch carrierTypeString! {
                // 2G
                case CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyWCDMA:
                    carrierType = SilverPlate.NetworkState.cellular2g
                    break
                    
                // 3G
                case CTRadioAccessTechnologyGPRS,
                     CTRadioAccessTechnologyeHRPD,
                     CTRadioAccessTechnologyHSDPA,
                     CTRadioAccessTechnologyHSUPA,
                     CTRadioAccessTechnologyCDMA1x,
                     CTRadioAccessTechnologyCDMAEVDORev0,
                     CTRadioAccessTechnologyCDMAEVDORevA,
                     CTRadioAccessTechnologyCDMAEVDORevB:
                    carrierType = SilverPlate.NetworkState.cellular3g
                    break
                    
                // 4G
                case CTRadioAccessTechnologyLTE:
                    carrierType = SilverPlate.NetworkState.cellular4g
                    break
                default:
                    carrierType = SilverPlate.NetworkState.cellular3g
                }
            }
            
        } else {
            print("Network not reachable")
            carrierType = SilverPlate.NetworkState.none
        }
        return carrierType
    }
    
    func sendReachabilityStatus() {
        SilverPlate.shared.internetStateChanged(state: getReachabilityStatus())
    }
    
    @objc func reachabilityDidChanged(note: NSNotification) {
        reachability = note.object as! Reachability
        _ = sendReachabilityStatus()
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
}
