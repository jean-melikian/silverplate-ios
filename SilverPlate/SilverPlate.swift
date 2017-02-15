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
    
    public enum Network: Int {
        case none = 0
        case wifi = 1
        case cellular = 2
    }
    
    public static let shared: SilverPlate = SilverPlate()
    private var connectivity: ConnectivityManager
    
    private init() {
        print("SilverPlate has just been initialized !")
        connectivity = ConnectivityManager()
    }
    
    public var onInternetStatusChanged: ((Network) -> Void)?
    
    internal func internetStatusChanged(status: Network) {
        if let internetStatusChangedClosure = self.onInternetStatusChanged {
            internetStatusChangedClosure(status)
        }
    }
    
    public func getReachabilityStatus() {
        connectivity.getReachabilityStatus()
    }
}
