//
//  SPDLocationSpeedProvider.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/3/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
import CoreLocation

protocol SPDLocationSpeedProviderDelegate: class {
    
    func didUpdate(speed: CLLocationSpeed)
}

protocol SPDLocationSpeedProvider: class {
    var delegate: SPDLocationSpeedProviderDelegate? { get set }
}

class SPDDefaultLocationSpeedProvider {
    weak var delegate: SPDLocationSpeedProviderDelegate?
    let locationProvider: SPDLocationProvider
    
    init(locationProvider: SPDLocationProvider) {
        self.locationProvider = locationProvider
        locationProvider.add(self)
    }
}

extension SPDDefaultLocationSpeedProvider: SPDLocationSpeedProvider {
    
}

extension SPDDefaultLocationSpeedProvider: SPDLocationConsumer {
    
    func consumeLocation(_ location: CLLocation) {
        let speed = max(location.speed, 0)
        
        delegate?.didUpdate(speed: speed)
    }
}