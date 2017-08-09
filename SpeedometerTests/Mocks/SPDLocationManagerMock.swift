//
//  SPDLocationManagerMock.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/9/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Speedometer

class SPDLocationManagerMock: SPDLocationManager {
    
    weak var delegate: SPDLocationManagerDelegate?
    weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
    
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    
    var requestedWhenInUseAuthorization = false
    var didStartUpdatingLocation = false
    var didStopUpdatingLocation = false
    
    func requestWhenInUseAuthorization() {
        requestedWhenInUseAuthorization = true
    }
    
    func startUpdatingLocation() {
        didStartUpdatingLocation = true
    }
    
    func stopUpdatingLocation() {
        didStopUpdatingLocation = true
    }
    
}
