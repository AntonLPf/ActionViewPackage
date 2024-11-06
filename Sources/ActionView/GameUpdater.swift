//
//  File.swift
//  ActionView
//
//  Created by Антон Шишкин on 07.11.24.
//

import Foundation

public protocol GameUpdater {
    var isGameSaveNeeded: Bool { get }
}
