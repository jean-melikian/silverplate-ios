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
    
    // Closures objects arrays
    public var onInternetStateChanged: (AnyClass, [((NetworkState) -> Void)]) = (NSObject.self, [])
    public var onBatteryLowLevel: [((Int) -> Void)] = []
    public var onBatteryStateChanged: [((BatteryState, Int) -> Void)] = []
    
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
        self.onInternetStateChanged.1.forEach { (closure) in
            closure(state)
        }
    }
    
    internal func batteryLowLevel(level: Int) {
        print("SilverPlate -> Battery level: \(level)%")
        self.onBatteryLowLevel.forEach { (closure) in
            closure(level)
        }
    }
    
    internal func batteryStateChanged(state: SilverPlate.BatteryState, level: Int) {
        print("SilverPlate -> Battery state and level: \(state) (\(level)%)")
        self.onBatteryStateChanged.forEach { (closure) in
            closure(state, level)
        }
    }

    // -- PUBLIC --------
    public static let shared: SilverPlate = SilverPlate()
    
    public func registerOnInternetStatusChange(registering: Any, closure: @escaping ((NetworkState) -> Void)) {
        self.onInternetStateChanged.1.append(closure)
        print("Registered for InternetStatusChange")
    }
    
    public func unregister(manager: Manager) {
        print("Unregistering for \(manager.type)")
    }
    
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
