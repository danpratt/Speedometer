//
//  SPDLocationConsumerMock.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/9/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Speedometer

class SPDLocationConsumerMock : SPDLocationConsumer {
    
    var lastLocation: CLLocation?
    
    func consumeLocation(_ location: CLLocation) {
        lastLocation = location
    }
    
}
