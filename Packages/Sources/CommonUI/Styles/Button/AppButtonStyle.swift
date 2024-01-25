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

    private enum CodingKeys: String, CodingKey {
        // SeeAlso: `JSONMerger.RestrictedMergerKeys.buttonShape`
        case shape = "buttonShape"
        case backgroundColor
        case textColor
        case padding
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

public extension [String: AppButtonStyle] {
    static var `default`: [String: AppButtonStyle] {
        [
            AppButtonType.primary.rawValue: AppButtonStyle(shape: .capsule, backgroundColor: "primary500", textColor: "text500", padding: [15, 30, 15, 30]),
            AppButtonType.secondary.rawValue: AppButtonStyle(shape: .default, backgroundColor: "clear", textColor: "primary500", padding: [10]),
        ]
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
