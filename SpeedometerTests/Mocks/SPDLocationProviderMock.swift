//
//  SPDLocationProviderMock.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/9/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationProviderMock: SPDLocationProvider {
    
    var lastConsumer: SPDLocationConsumer?
    
    func add(_ consumer: SPDLocationConsumer) {
        lastConsumer = consumer
    }
}
