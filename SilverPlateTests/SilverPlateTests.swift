//
//  SilverPlateTests.swift
//  SilverPlate
//
//  Created by Jean-Christophe MELIKIAN on 12/02/2017.
//  Copyright © 2017 ozonePowered. All rights reserved.
//

import XCTest
@testable import SilverPlate

class SilverPlateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        UIDevice.current.isBatteryMonitoringEnabled = true
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    */
    
    func testInternetConnection() {
       
        SilverPlate.shared.onInternetStateChanged = { (state) in
            print("\nCurrent network status: \(state) \n")
            XCTAssert(state != SilverPlate.NetworkState.none)
        }
    }
}
