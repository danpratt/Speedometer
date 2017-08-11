//
//  SPDLocationSpeedProviderTests.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/11/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Speedometer

class SPDLocationSpeedProviderTests: XCTestCase {
    
    var sut: SPDLocationSpeedProvider!
    
    var locationProvider: SPDLocationProviderMock!
    var delegate: SPDLocationSpeedProviderDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        locationProvider = SPDLocationProviderMock()
        delegate = SPDLocationSpeedProviderDelegateMock()
        
        sut = SPDDefaultLocationSpeedProvider(locationProvider: locationProvider)
        sut.delegate = delegate
    }
    
    func test_consumerLocation_speedLessThanZero_ProvideZeroToDelegate() {
        // Arrange
        let location = createLocation(with: -10)
        // Act
        locationProvider.lastConsumer?.consumeLocation(location)
        // Assert
        XCTAssertEqual(0, delegate.lastKnownSpeed)
    }
    
    func test_consumerLocation_speedGreaterThanZero_ProvideSpeedToDelegate() {
        // Arrange
        let location = createLocation(with: 10)
        // Act
        locationProvider.lastConsumer?.consumeLocation(location)
        // Assert
        XCTAssertEqual(10, delegate.lastKnownSpeed)
    }
    
    func createLocation(with speed: CLLocationSpeed) -> CLLocation {
        let coordinate = CLLocationCoordinate2D()
        return CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: speed, timestamp: Date())
    }
    
}
