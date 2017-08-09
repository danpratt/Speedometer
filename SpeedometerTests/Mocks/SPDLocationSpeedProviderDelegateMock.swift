//
//  SPDLocationSpeedProviderDelegateMock.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/9/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Speedometer

class SPDLocationSpeedProviderDelegateMock: SPDLocationSpeedProviderDelegate {
    
    var lastKnownSpeed: CLLocationSpeed?
    
    func didUpdate(speed: CLLocationSpeed) {
        lastKnownSpeed = speed
    }
    
}
