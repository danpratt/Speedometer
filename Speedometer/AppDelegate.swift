//
//  AppDelegate.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/4/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?
    let mainAssembler = MainAssembler()
    let locationAuthorization: SPDLocationAuthorization
    
    override init() {
        locationAuthorization = mainAssembler.resolver.resolve(SPDLocationAuthorization.self)!
        super.init()
        
        locationAuthorization.delegate = self
        
    }
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        locationAuthorization.checkAuthorization()
        
        return true
        
    }
    
}

extension AppDelegate: SPDLocationAuthorizationDelegate {
    
    func authorizationDenied(for locationAuthorization: SPDLocationAuthorization) {
        let alertController = UIAlertController(title: "Permission Denied", message: "Speedometer needs access to your location to functino", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
}
