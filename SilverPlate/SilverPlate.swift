//
//  SilverPlate.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 11/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import Foundation
import SystemConfiguration

internal protocol SilverPlateProtocol {
    func internetStatusChanged(status: SilverPlate.Network)
    func batteryStateChanged(status: SilverPlate.Battery)
    
}

public final class SilverPlate: SilverPlateProtocol {
    
    // -- PRIVATE -------
    private var connectivity: ConnectivityManager
    private var battery: BatteryManager
    
    private init() {
        connectivity = ConnectivityManager()
        battery = BatteryManager()
        print("SilverPlate has just been initialized !")
    }
    
    // -- INTERNAL ------
    
    internal func internetStatusChanged(status: Network) {
        print("Internet is reachable via: \(status)")
        if let internetStatusChangedClosure = self.onInternetStatusChanged {
            internetStatusChangedClosure(status)
        }
    }
    
    internal func batteryStateChanged(status: Battery) {
        print("SilverPlate -> Battery level: \(status)")
        if let batteryStateChangedClosure = self.onBatteryStatusChanged {
            batteryStateChangedClosure(status)
        }
    }
    
    // -- PUBLIC --------
    public static let shared: SilverPlate = SilverPlate()
    public var onInternetStatusChanged: ((Network) -> Void)?
    public var onBatteryStatusChanged: ((Battery) -> Void)?
    
    public func getReachabilityStatus() {
        connectivity.sendReachabilityStatus()
    }

    
    
}
