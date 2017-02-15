//
//  SilverPlateTypes.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 15/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import Foundation

extension SilverPlate {
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
    
    public enum Battery: Int {
        case low
        case half
        case full
        
    }
}
