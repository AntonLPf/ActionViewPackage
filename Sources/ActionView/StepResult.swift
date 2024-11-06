//
//  File.swift
//  ActionView
//
//  Created by Антон Шишкин on 06.11.24.
//

import Foundation

public protocol StepResult: CustomStringConvertible, Identifiable {
    var isGameSaveNeeded: Bool { get }
    
    var isFinal: Bool { get }
    
    var id: String { get }
}

extension StepResult {
    var id: String {
        (self as CustomStringConvertible).description
    }
}
