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

    func makeBackgroundView() -> AnyView {
        switch styleGuide.shape {
        case .capsule:
            AnyView(Capsule().fill(styleGuide.backgroundColor))
        case .circle:
            AnyView(Circle().fill(styleGuide.backgroundColor))
        case .roundedRectabgle(let radius):
            AnyView(RoundedRectangle(cornerRadius: radius).fill(styleGuide.backgroundColor))
        case .default:
            AnyView(Rectangle().fill(styleGuide.backgroundColor))
        }
    }
}
