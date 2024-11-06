//
//  File.swift
//  ActionView
//
//  Created by Антон Шишкин on 06.11.24.
//

import Foundation

public protocol ActionNavigator {
    associatedtype ActionStepType: ActionStep
    
    var firstStep: ActionStepType { get set }
        
    var steps: [ActionStepType] { get set }
    
    var currentStep: ActionStepType { get }
    
    mutating func moveForward() throws
    
    mutating func setDataForCurrentStep(data: ActionStepType.StepDataType)
    
    func isDataAppropriateForCurrentStep(data: ActionStepType.StepDataType) -> Bool

    var finalResults: [ActionStepType.StepResultType] { get }
    
    var isGameSaveNeeded: Bool { get }
        
    func getStepData(stepType: ActionStepType.StepTypeType) -> ActionStepType.StepDataType?
    
    mutating func checkAndGoToNextStep(_ step: ActionStepType) throws
}

extension ActionNavigator {
    
    var currentStep: ActionStepType {
        if steps.isEmpty {
            return firstStep
        } else {
            return steps.last!
        }
    }
    
    var finalResults: [ActionStepType.StepResultType] {
        var finalResults = firstStep.results
        
        for step in self.steps {
            finalResults.append(contentsOf: step.results)
        }
        
        return finalResults.filter { $0.isFinal }
    }
    
    mutating func setDataForCurrentStep(data: ActionStepType.StepDataType) {
        guard isDataAppropriateForCurrentStep(data: data) else { return }

        if steps.isEmpty {
            firstStep.stepData = data
        } else {
            if let index = steps.firstIndex(where: { $0.stepType == currentStep.stepType }) {
                steps[index].stepData = data
            }
        }
    }
    
    var isGameSaveNeeded: Bool {
        var result = false
        
        for finalResult in finalResults {
            if finalResult.isGameSaveNeeded {
                result = true
                break
            }
        }
        
        return result
    }
    
    func getStepData(stepType: ActionStepType.StepTypeType) -> ActionStepType.StepDataType? {
        if firstStep.stepType == stepType {
            guard let data = firstStep.stepData else { return nil }
            return data
        }
        for step in self.steps {
            guard step.stepType == stepType else { return nil }
            guard let data = step.stepData else { return nil }
            return data
        }
        return nil
    }
    
    mutating func checkAndGoToNextStep(_ step: ActionStepType) throws {
        guard currentStep.stepData != nil else { throw NavigatorError.dataNotFull }
        
        steps.append(step)
    }
}
