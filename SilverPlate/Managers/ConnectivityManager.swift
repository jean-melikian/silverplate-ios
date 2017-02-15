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
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    func sendReachabilityStatus() {
        let networkInfo = CTTelephonyNetworkInfo();
        let carrierTypeString = networkInfo.currentRadioAccessTechnology
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
                SilverPlate.shared.internetStatusChanged(status: SilverPlate.Network.wifi)
            } else if reachability.isReachableViaWWAN {
                print("Reachable via Cellular")
                var carrierType: SilverPlate.Network
                switch carrierTypeString! {
                // 2G
                case CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyWCDMA:
                    carrierType = SilverPlate.Network.cellular2g
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
                    carrierType = SilverPlate.Network.cellular3g
                    break
                    
                // 4G
                case CTRadioAccessTechnologyLTE:
                    carrierType = SilverPlate.Network.cellular4g
                    break
                default:
                    carrierType = SilverPlate.Network.cellular3g
                }
                SilverPlate.shared.internetStatusChanged(status: carrierType)
            }
        } else {
            print("Network not reachable")
            SilverPlate.shared.internetStatusChanged(status: SilverPlate.Network.none)
        }
    }
    
    @objc func reachabilityChanged(note: NSNotification) {
        
        reachability = note.object as! Reachability
        sendReachabilityStatus()
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
}
