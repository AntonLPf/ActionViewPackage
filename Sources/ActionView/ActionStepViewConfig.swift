//
//  ActionStepViewConfig.swift
//  ActionView
//
//  Created by Антон Шишкин on 06.11.24.
//

import Foundation

public protocol ActionStepViewConfig {
    associatedtype T: ActionNavigator
    
    var navigator: T { get set }
    
    var dismissSheet: ()->() { get }
        
    mutating func closeActionView()
            
    mutating func nextButtonPressed()
        
}

public extension ActionStepViewConfig {
    
    mutating func closeActionView() {
        dismissSheet()
    }
}
