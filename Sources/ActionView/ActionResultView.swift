//
//  ActionResultView.swift
//  ActionView
//
//  Created by Антон Шишкин on 07.11.24.
//

import SwiftUI

struct ActionResultView<Content: View, Config: ActionStepViewConfig>: View {
    @Binding var config: Config
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack {
            if #available(iOS 16.4, *) {
                content()
                    .scrollBounceBehavior(.basedOnSize)
            } else {
                content()
            }
            Spacer()
            Button {
                config.dismissSheet()
            } label: {
                Text(config.navigator.isGameSaveNeeded ? "Save" : "Close")
                    .actionButtonStyled(closeButton: config.navigator.isGameSaveNeeded).padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    config.closeActionView()
                }
            }
        }
    }
}
