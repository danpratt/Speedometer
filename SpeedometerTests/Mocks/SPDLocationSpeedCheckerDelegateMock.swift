//
//  SPDLocationSpeedCheckerDelegateMock.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/9/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationSpeedCheckerDelegateMock: SPDLocationSpeedCheckerDelegate {
    
    var didChangeExceedingMaximumSpeed = false
    
    func exceedingMaximumSpeedChanged(for speedChecker: SPDLocationSpeedChecker) {
        didChangeExceedingMaximumSpeed = true
    }
    
}
