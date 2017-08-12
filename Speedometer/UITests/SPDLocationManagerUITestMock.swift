//
//  SPDLocationManagerUITestMock.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/11/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import UIKit
import CoreLocation
import Swinject

class SPDLocationManagerUITestMock {
    
    weak var delegate: SPDLocationManagerDelegate?
    weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
    
    var authorizationStatus: CLAuthorizationStatus = .notDetermined {
        didSet {
            authorizationDelegate?.locationManager(self, didChangeAuthorization: authorizationStatus)
        }
    }
}

extension SPDLocationManagerUITestMock: SPDLocationManager {
    
    func requestWhenInUseAuthorization() {
        guard let viewController = UIApplication.shared.delegate?.window??.rootViewController else { return }
        
        let alertController = UIAlertController(title: "Location Authorization", message: nil, preferredStyle: .alert)
        let allowAction = UIAlertAction(title: "Allow", style: .default) { [weak self] (_) in
            self?.authorizationStatus = .authorizedWhenInUse
        }
        
        let dontAllowAction = UIAlertAction(title: "Don't Allow", style: .cancel) { [weak self] (_) in
            self?.authorizationStatus = .denied
        }
        
        alertController.addAction(allowAction)
        alertController.addAction(dontAllowAction)
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    func startUpdatingLocation() {
        delayedPostLocation()
    }
    
    func stopUpdatingLocation() {
        // Do nothing
    }
}

private extension SPDLocationManagerUITestMock {
    func delayedPostLocation() {
        let coordinate = CLLocationCoordinate2D()
        let location = CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: 20, timestamp: Date())
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) { 
            [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.delegate?.locationManager(strongSelf, didUpdateLocations: [location])
        }
    }
}

class SPDLocationManagerUITestMockAssembly : Assembly {
    
    func assemble(container: Container) {
        container.register(SPDLocationManager.self) { r in
            return SPDLocationManagerUITestMock()
        }
    }
    
}
