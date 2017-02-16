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
    func internetStateChanged(state: SilverPlate.NetworkState)
    func batteryLowLevel(level: Int)
    func batteryStateChanged(state: SilverPlate.BatteryState, level: Int)
}

public final class SilverPlate: SilverPlateProtocol {
    
    // -- PRIVATE -------
    internal let device = UIDevice.current
    private var connectivity: ConnectivityManager
    private var battery: BatteryManager?
    
    private init() {
        device.isBatteryMonitoringEnabled = true
        connectivity = ConnectivityManager()
        if UIDevice.current.isBatteryMonitoringEnabled {
            battery = BatteryManager()
        } else {
            battery = nil
        }
        print("SilverPlate has just been initialized !")
    }
    
    // -- INTERNAL ------
    
    internal func internetStateChanged(state: NetworkState) {
        print("Internet is reachable via: \(state)")
        if let internetStateChangedClosure = self.onInternetStateChanged {
            internetStateChangedClosure(state)
        }
    }
    
    internal func batteryLowLevel(level: Int) {
        print("SilverPlate -> Battery level: \(level)%")
        if let batteryLowLevelClosure = self.onBatteryLowLevel {
            batteryLowLevelClosure(level)
        }
    }
    
    internal func batteryStateChanged(state: SilverPlate.BatteryState, level: Int) {
        print("SilverPlate -> Battery state and level: \(state) (\(level)%)")
        if let batteryStateChangedClosure = self.onBatteryStateChanged {
            batteryStateChangedClosure(state, level)
        }
    }
    
    // -- PUBLIC --------
    public static let shared: SilverPlate = SilverPlate()
    public var onInternetStateChanged: ((NetworkState) -> Void)?
    public var onBatteryLowLevel: ((Int) -> Void)?
    public var onBatteryStateChanged: ((BatteryState, Int) -> Void)?
    
    public func getReachabilityStatus() -> NetworkState {
        return connectivity.getReachabilityStatus()
    }
    
    public func getBatteryLevel() -> Int {
        if battery != nil {
            return (battery?.getBatteryLevel())!
        }
        return -1
    }
    
    public func getBatteryState() -> BatteryState {
        if battery != nil {
            return (battery?.getBatteryState())!
        }
        return BatteryState.unknown
    }
    
}
