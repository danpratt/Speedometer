//
//  SPDLocationProviderTests.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/10/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Speedometer

class SPDLocationProviderTests: XCTestCase {
    
    var sut: SPDLocationProvider!
    
    var locationManagerMock: SPDLocationManagerMock!
    var locationAuthorizationMock: SPDLocationAuthorizationMock!
    var consumerMock: SPDLocationConsumerMock!
    
    override func setUp() {
        super.setUp()
        
        locationManagerMock = SPDLocationManagerMock()
        locationAuthorizationMock = SPDLocationAuthorizationMock()
        consumerMock = SPDLocationConsumerMock()
        
        sut = SPDDefaultLocationProvider(locationManager: locationManagerMock, locationAuthorization: locationAuthorizationMock)
        sut.add(consumerMock)
    }
    
    func test_authorizedNotification_startUpdatingLocation() {
        // Arrange
        // Act
        NotificationCenter.default.post(name: NSNotification.Name.SPDLocationAuthorized, object: locationAuthorizationMock)
        // Assert
        XCTAssertTrue(locationManagerMock.didStartUpdatingLocation)
    }
    
    func test_updatedLocations_passesLocationsToConsumers() {
        // Arrange
        let expectedLocation = CLLocation()
        // Act
        locationManagerMock.delegate?.locationManager(locationManagerMock, didUpdateLocations: [expectedLocation])
        // Assert
        XCTAssertEqual(expectedLocation, consumerMock.lastLocation)
    }
    
    func test_updatedLocations_noLocations_nothingPassesToConsumers() {
        // Arrange
        // Act
        locationManagerMock.delegate?.locationManager(locationManagerMock, didUpdateLocations: [])
        // Assert
        XCTAssertNil(consumerMock.lastLocation)
    }
    
    func test_updatedLocations_severalLocations_mostRecentLocationPassedToConsumers() {
        // Arrange
        let timeStamp = Date()
        let oldLocation = createLocation(with: timeStamp)
        let newLocation = createLocation(with: timeStamp.addingTimeInterval(60))
        // Act
        locationManagerMock.delegate?.locationManager(locationManagerMock, didUpdateLocations: [oldLocation, newLocation])
        // Assert
        XCTAssertEqual(newLocation, consumerMock.lastLocation)
    }
    
    func test_deinit_stopUpdatingLocations() {
        // Arrange
        // Act
        sut = nil
        // Assert
        XCTAssertTrue(locationManagerMock.didStopUpdatingLocation)
    }
    
    func createLocation(with date: Date) -> CLLocation {
        let coordinate = CLLocationCoordinate2D()
        return CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: 0, timestamp: date)
    }
}


