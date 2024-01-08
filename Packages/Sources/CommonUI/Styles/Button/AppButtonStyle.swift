//
//  AppButtonStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppButtonStyle: ButtonStyle, Equatable {
    public let styleGuide: StyleGuide

    public init(styleGuide: StyleGuide) {
        self.styleGuide = styleGuide
    }

    public func makeBody(configuration: AppButtonStyle.Configuration) -> some View {
        configuration.label
            .foregroundColor(styleGuide.textColor)
            .padding(styleGuide.padding)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .background(makeBackgroundView())
    }
}

public extension AppButtonStyle {
    struct StyleGuide: Equatable {
        public let shape: AppButtonShape
        public let backgroundColor: Color
        public let textColor: Color
        public let padding: EdgeInsets

        public init(
            shape: AppButtonShape,
            backgroundColor: Color,
            textColor: Color,
            padding: EdgeInsets
        ) {
            self.shape = shape
            self.backgroundColor = backgroundColor
            self.textColor = textColor
            self.padding = padding
        }
    }
}

extension AppButtonStyle {
    @ViewBuilder func makeBackgroundView() -> some View {
        switch styleGuide.shape {
        case .capsule:
            Capsule().fill(styleGuide.backgroundColor)
        case .circle:
            Circle().fill(styleGuide.backgroundColor)
        case .roundedRectabgle(let radius):
            RoundedRectangle(cornerRadius: radius).fill(styleGuide.backgroundColor)
        case .default:
            Rectangle().fill(styleGuide.backgroundColor)
        }
    }
}
