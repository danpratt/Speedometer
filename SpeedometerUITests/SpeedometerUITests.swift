//
//  SpeedometerUITests.swift
//  SpeedometerUITests
//
//  Created by Daniel Pratt on 8/4/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import XCTest

class SpeedometerUITests: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        
        continueAfterFailure = false
        app.launchArguments = ["UITests"]
        app.launch()

    }
    
    
}
