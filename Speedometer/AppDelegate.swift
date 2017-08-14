//
//  AppDelegate.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/4/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import UIKit
import SwinjectStoryboard

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

private extension AppDelegate {
    
    func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil)
        
        window.backgroundColor = UIColor.black
        window.rootViewController = storyboard.instantiateInitialViewController()
        
        self.window = window
    }
    
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        setupWindow()
        
        if ProcessInfo.processInfo.arguments.contains("UITests") {
            UIApplication.shared.keyWindow?.layer.speed = 100
        }
        
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
