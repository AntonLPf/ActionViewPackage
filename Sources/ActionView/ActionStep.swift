//
//  ActionStep.swift
//  ActionView
//
//  Created by Антон Шишкин on 06.11.24.
//

import Foundation

public protocol ActionStep: Hashable {
    associatedtype StepTypeType: StepType
    associatedtype StepDataType: StepData
    associatedtype StepResultType: StepResult
    
    var stepType: StepTypeType { get }
    var stepData: StepDataType? { get set }
    
    var results: [StepResultType] { get set }
    
    func hash(into hasher: inout Hasher)
}

public extension ActionStep {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(stepType)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.stepType == rhs.stepType
    }

}
