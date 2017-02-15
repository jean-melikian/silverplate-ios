//
//  ConnectivityManager.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 14/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import Foundation
import ReachabilitySwift

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
    
    func getReachabilityStatus() {
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
                SilverPlate.shared.internetStatusChanged(status: SilverPlate.Network.wifi)
            } else if reachability.isReachableViaWWAN {
                print("Reachable via Cellular")
                SilverPlate.shared.internetStatusChanged(status: SilverPlate.Network.cellular)
            }
        } else {
            print("Network not reachable")
            SilverPlate.shared.internetStatusChanged(status: SilverPlate.Network.none)
        }
    }
    
    @objc func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
                SilverPlate.shared.internetStatusChanged(status: SilverPlate.Network.wifi)
            } else if reachability.isReachableViaWWAN {
                print("Reachable via Cellular")
                SilverPlate.shared.internetStatusChanged(status: SilverPlate.Network.cellular)
            }
        } else {
            print("Network not reachable")
            SilverPlate.shared.internetStatusChanged(status: SilverPlate.Network.none)
        }
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
}
