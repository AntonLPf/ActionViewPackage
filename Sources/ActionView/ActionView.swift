// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct ActionView<Content: View>: View {
    
    let title: String
    let nextButtonCustomName: String?
    let nextButtonAction: ()->()
    let isCloseButtonStyle: Bool
    let cancelAction: ()->()
    let content: Content

    init(title: String,
         nextButtonCustomName: String? = nil,
         nextButtonAction: @escaping ()->(),
         isCloseButtonStyle: Bool = false,
         cancelAction: @escaping ()->(),
         @ViewBuilder content: () -> Content) {
        self.title = title
        self.nextButtonCustomName = nextButtonCustomName
        self.nextButtonAction = nextButtonAction
        self.isCloseButtonStyle = isCloseButtonStyle
        self.cancelAction = cancelAction
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            if #available(iOS 16.4, *) {
                content
                    .scrollBounceBehavior(.basedOnSize)
            } else {
                content
            }
            Spacer()
            Button {
                nextButtonAction()
            } label: {
                Text(nextButtonCustomName ?? "Next")
                    .actionButtonStyled(closeButton: isCloseButtonStyle).padding()
            }
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    cancelAction()
                }
            }
        }
    }
}
