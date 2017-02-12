//
//  SilverPlate.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 11/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import Foundation
import SystemConfiguration

protocol SilverPlateDelegate {
    func onInternetStatusChanged(status: Network)
}

class SilverPlateDelegateImplementation: SilverPlateDelegate {
    var internetStatusChanged: ((Network) -> Void)?
    
    func onInternetStatusChanged(status: Network) {
        if let internetStatusChangedClosure = self.internetStatusChanged {
            internetStatusChangedClosure(status)
        }
    }
}

open class SilverPlate {
    
    var delegate: SilverPlateDelegateImplementation?
    
    func isInternetAvailable() {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            self.delegate?.onInternetStatusChanged(status: Network.none)
            return
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            self.delegate?.onInternetStatusChanged(status: Network.none)
            return
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        if(isReachable && !needsConnection) {
            self.delegate?.onInternetStatusChanged(status: Network.wifi)
            return
        } else {
            self.delegate?.onInternetStatusChanged(status: Network.none)
            return
        }
    }
}

enum Network: Int {
    case none = 0
    case wifi = 1
    case wwan = 2
}


