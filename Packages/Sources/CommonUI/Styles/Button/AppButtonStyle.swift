//
//  AppButtonStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppButtonStyle: Equatable, Codable {
    public let shape: AppButtonShape
    public let backgroundColor: String
    public let textColor: String
    public let padding: [CGFloat]

    public func makeStyleGuide(designStystem: AppDesignSystem) -> StyleGuide {
        StyleGuide(
            shape: shape,
            backgroundColor: designStystem.colors.getColor(named: backgroundColor) ?? designStystem.colors.clear,
            textColor: designStystem.colors.getColor(named: textColor) ?? designStystem.colors.clear,
            padding: padding.edgeInsets
        )
    }
}

public extension AppButtonStyle {
    struct StyleGuide: Equatable {
        public let shape: AppButtonShape
        public let backgroundColor: AppColor
        public let textColor: AppColor
        public let padding: EdgeInsets

        public init(
            shape: AppButtonShape,
            backgroundColor: AppColor,
            textColor: AppColor,
            padding: EdgeInsets
        ) {
            self.shape = shape
            self.backgroundColor = backgroundColor
            self.textColor = textColor
            self.padding = padding
        }
    }
}

extension AppButtonStyle.StyleGuide: ButtonStyle {
    public func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor.color)
            .padding(padding)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .background(makeBackgroundView())
    }
}

private extension AppButtonStyle.StyleGuide {
    @ViewBuilder func makeBackgroundView() -> some View {
        switch shape {
        case .capsule:
            Capsule().fill(backgroundColor.color ?? .clear)
        case .circle:
            Circle().fill(backgroundColor.color ?? .clear)
        case .roundedRectangle(let radius):
            RoundedRectangle(cornerRadius: radius).fill(backgroundColor.color ?? .clear)
        case .default:
            Rectangle().fill(backgroundColor.color ?? .clear)
        }
    }
}
