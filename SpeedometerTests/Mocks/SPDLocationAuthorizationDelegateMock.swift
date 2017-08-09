//
//  SPDLocationAuthorizationDelegateMock.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/9/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationAuthorizationDelegateMock: SPDLocationAuthorizationDelegate {
    
    var authorizationWasDenied = false
    
    func authorizationDenied(for locationAuthorization: SPDLocationAuthorization) {
        authorizationWasDenied = true
    }
    
}
