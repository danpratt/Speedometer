//
//  MainAssembler.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/8/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
import Swinject

class MainAssembler {
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    private let assembler = Assembler()
    
    init() {
        assembler.apply(assembly: SPDLocationManagerAssembly())
        assembler.apply(assembly: SPDLocationAuthorizationAssembly())
        assembler.apply(assembly: SPDLocationProviderAssembly())
        assembler.apply(assembly: SPDLocationSpeedProviderAssembly())
        assembler.apply(assembly: SPDLocationSpeedCheckerAssembly())
        
    }
}
