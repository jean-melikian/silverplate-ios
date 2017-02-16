//
//  SilverPlateTypes.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 15/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import Foundation

extension SilverPlate {
    public enum NetworkState: String {
        case none
        case wifi
        case cellular2g
        case cellular3g
        case cellular4g
        
        public var description: String {
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
    
    public enum BatteryState : Int {
        case unknown
        case unplugged // on battery, discharging
        case charging // plugged in, less than 100%
        case full // plugged in, at 100%
        
        public var description: String {
            switch self {
            case .unknown:
                return "unknown"
            case .unplugged:
                return "unplugged"
            case .charging:
                return "charging"
            case .full:
                return "full"
            }
        }
    }
}
