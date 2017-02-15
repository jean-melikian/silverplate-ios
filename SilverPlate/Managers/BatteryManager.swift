//
//  BatteryManager.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 15/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import Foundation

internal class BatteryManager {
    init() {
        NotificationCenter.default.addObserver(self, selector: Selector(("batteryStateDidChange:")), name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: Selector(("batteryLevelDidChange:")), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
    }
    
    
}
