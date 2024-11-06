//
//  ActionButtonStyle.swift
//  ActionView
//
//  Created by Антон Шишкин on 06.11.24.
//

import SwiftUI

struct ActionButtonStyle: ViewModifier {
    let closeButton: Bool
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(closeButton ? Color.red: Color.blue)
            .cornerRadius(16)
            .foregroundColor(.white)
            .padding(8)
    }
    
}

extension View {
    func actionButtonStyled(closeButton: Bool = false) -> some View {
        modifier(ActionButtonStyle(closeButton: closeButton))
    }
}
