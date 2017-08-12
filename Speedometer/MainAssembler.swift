//
//  MainAssembler.swift
//  Speedometer
//
//  Created by Daniel Pratt on 8/8/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class MainAssembler {
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    private let assembler = Assembler(container: SwinjectStoryboard.defaultContainer)
    
    init() {
        assembler.apply(assembly: SPDLocationManagerAssembly())
        assembler.apply(assembly: SPDLocationAuthorizationAssembly())
        assembler.apply(assembly: SPDLocationProviderAssembly())
        assembler.apply(assembly: SPDLocationSpeedProviderAssembly())
        assembler.apply(assembly: SPDLocationSpeedCheckerAssembly())
     
        assembler.apply(assembly: ViewControllerAssembly())
        
        if ProcessInfo.processInfo.arguments.contains("UITests") {
            assembler.apply(assembly: SPDLocationManagerUITestMockAssembly())
        }
    }
}
