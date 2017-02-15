//
//  SilverPlate.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 11/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import Foundation
import SystemConfiguration

internal protocol SilverPlateDelegate {
    func internetStatusChanged(status: SilverPlate.Network)
}

public final class SilverPlate: SilverPlateDelegate {
    
    public enum Network: String {
        case none
        case wifi
        case cellular2g
        case cellular3g
        case cellular4g
        
        var description: String {
            switch self {
            case .none:
                return "none"
            case .wifi:
                return "wifi"
            case .cellular2g:
                return "cellular2g"
            case .cellular3g:
                return "cellular3g"
            case .cellular4g:
                return "cellular4g"
            }
        }
    }
    
    public static let shared: SilverPlate = SilverPlate()
    private var connectivity: ConnectivityManager
    
    private init() {
        print("SilverPlate has just been initialized !")
        connectivity = ConnectivityManager()
    }
    
    public var onInternetStatusChanged: ((Network) -> Void)?
    
    internal func internetStatusChanged(status: Network) {
        print("Internet is reachable via: \(status)")
        if let internetStatusChangedClosure = self.onInternetStatusChanged {
            internetStatusChangedClosure(status)
        }
    }
    
    public func getReachabilityStatus() {
        connectivity.sendReachabilityStatus()
    }
}
