//
//  SPDLocationAuthorizationMock.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/9/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationAuthorizationMock: SPDLocationAuthorization {
    
    weak var delegate: SPDLocationAuthorizationDelegate?
    var didCheckAuthorization = false
    
    func checkAuthorization() {
        didCheckAuthorization = true
    }
    
    
    
}
