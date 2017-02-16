//
//  BatteryManager.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 15/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import Foundation

internal class BatteryManager {
    let device = UIDevice.current
    let minimumBatteryLevel: Int = 40
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.batteryStateDidChange),
                                               name: NSNotification.Name.UIDeviceBatteryStateDidChange,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.batteryLevelDidChange),
                                               name: NSNotification.Name.UIDeviceBatteryLevelDidChange,
                                               object: nil)
    }
    
    @objc func batteryLevelDidChange(notification: NSNotification) {
        sendBatteryLowLevel()
    }
    
    @objc func batteryStateDidChange(notification: NSNotification) {
        sendBatteryStateChanged()
    }
    
    func sendBatteryLowLevel() {
        if  getBatteryLevel() <= minimumBatteryLevel {
            SilverPlate.shared.batteryLowLevel(level: getBatteryLevel())
        }
    }
    
    func sendBatteryStateChanged() {
        SilverPlate.shared.batteryStateChanged(state: getBatteryState(), level: getBatteryLevel())
    }
    
    func getBatteryLevel() -> Int {
        if device.isBatteryMonitoringEnabled {
            return Int(device.batteryLevel * 100)
        }
        return -1
    }
    
    func getBatteryState() -> SilverPlate.BatteryState {
        switch device.batteryState {
        case .unknown:
            return SilverPlate.BatteryState.unknown
        case .unplugged:
            return SilverPlate.BatteryState.unplugged
        case .charging:
            return SilverPlate.BatteryState.charging
        case .full:
            return SilverPlate.BatteryState.full
        }
    }
}
