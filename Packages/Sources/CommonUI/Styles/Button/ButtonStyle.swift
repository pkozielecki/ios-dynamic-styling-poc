//
//  AppButtonStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppButtonStyle: ButtonStyle {
    let type: AppButtonType
    let styleGuide: StyleGuide

    public init(type: AppButtonType, styleGuide: StyleGuide) {
        self.type = type
        self.styleGuide = styleGuide
    }

    public func makeBody(configuration: AppButtonStyle.Configuration) -> some View {
        switch type {
        case .primary:
            configuration.label
                .foregroundColor(styleGuide.textColor)
                .padding(styleGuide.padding)
                .background(Capsule().fill(styleGuide.backgroundColor))
                .opacity(configuration.isPressed ? 0.5 : 1.0)

        case .secondry:
            configuration.label
                .foregroundColor(styleGuide.backgroundColor)
                .padding(styleGuide.padding)
                .background(.clear)
                .opacity(configuration.isPressed ? 0.5 : 1.0)
        }
    }
}

extension AppButtonStyle {
    public struct StyleGuide: Equatable {
        public let backgroundColor: Color
        public let textColor: Color
        public let padding: EdgeInsets

        public init(designSystem: DesignSystem) {
            backgroundColor = designSystem.colors.primary500
            textColor = designSystem.colors.text500
            padding = .init(top: 15, leading: 30, bottom: 15, trailing: 30) // TODO: Get padding from Design System
        }
    }
}
