//
//  SPDLocationSpeedCheckerTests.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/11/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Speedometer

class SPDLocationSpeedCheckerTests: XCTestCase {
    
    var sut: SPDLocationSpeedChecker!
    
    var locationProvider: SPDLocationProviderMock!
    var delegate: SPDLocationSpeedCheckerDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        locationProvider = SPDLocationProviderMock()
        delegate = SPDLocationSpeedCheckerDelegateMock()
        
        sut = SPDDefaultLocationSpeedChecker(locationProvider: locationProvider)
        sut.delegate = delegate
    }
    
    func test_isExceedingMaximumSpeed_maxSpeedIsNil_false() {
        // Arrange
        sut.maximumSpeed = nil
        let location = createLocation(with: 1000)
        // Act
        locationProvider.lastConsumer?.consumeLocation(location)
        // Assert
        XCTAssertFalse(sut.isExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maxSpeedIsNotExceeded_false() {
        // Arrange
        sut.maximumSpeed = 100
        let location = createLocation(with: 90)
        // Act
        locationProvider.lastConsumer?.consumeLocation(location)
        // Assert
        XCTAssertFalse(sut.isExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maxSpeedIsExceeded_true() {
        // Arrange
        sut.maximumSpeed = 100
        let location = createLocation(with: 110)
        // Act
        locationProvider.lastConsumer?.consumeLocation(location)
        // Assert
        XCTAssertTrue(sut.isExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maxSpeedIsExceeded_delegateIsInformed() {
        // Arrange
        sut.maximumSpeed = 100
        let location = createLocation(with: 110)
        // Act
        locationProvider.lastConsumer?.consumeLocation(location)
        // Assert
        XCTAssertTrue(delegate.didChangeExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maxSpeedIsSetToExceededValue_true() {
        // Arrange
        let location = createLocation(with: 110)
        locationProvider.lastConsumer?.consumeLocation(location)
        // Act
        sut.maximumSpeed = 100
        // Assert
        XCTAssertTrue(sut.isExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maxSpeedIsSetToExceededValue_delegateIsInformed() {
        // Arrange
        let location = createLocation(with: 110)
        locationProvider.lastConsumer?.consumeLocation(location)
        // Act
        sut.maximumSpeed = 100
        // Assert
        XCTAssertTrue(delegate.didChangeExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_propertyDoesNotChange_delegateIsNotInformed() {
        // Arrange
        sut.maximumSpeed = 100
        let firstLocation = createLocation(with: 110)
        let SecondLocation = createLocation(with: 115)
        locationProvider.lastConsumer?.consumeLocation(firstLocation)
        delegate.didChangeExceedingMaximumSpeed = false
        // Act
        locationProvider.lastConsumer?.consumeLocation(SecondLocation)
        // Assert
        XCTAssertFalse(delegate.didChangeExceedingMaximumSpeed)
    }
    
    func createLocation(with speed: CLLocationSpeed) -> CLLocation {
        let coordinate = CLLocationCoordinate2D()
        return CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: speed, timestamp: Date())
    }
}
