//
//  AppTextModifier.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppTextModifier: ViewModifier {
    public let styleGuide: StyleGuide

    public init(styleGuide: StyleGuide) {
        self.styleGuide = styleGuide
    }

    public func body(content: Content) -> some View {
        content
            .font(styleGuide.font.weight(styleGuide.fontWeight))
            .foregroundColor(styleGuide.color)
    }
}

public extension Text {
    func textStyle(_ styleGuide: AppTextModifier.StyleGuide) -> some View {
        modifier(AppTextModifier(styleGuide: styleGuide))
    }
}

public extension Text {
    @ViewBuilder func appTextStyleFor(_ type: AppTextType, appStyle: AppStyle) -> some View {
        if let style = appStyle.getTextStyle(for: type) {
            textStyle(style)
        }
    }
}

public extension AppTextModifier {
    struct StyleGuide: Equatable {
        public let font: Font
        public let fontWeight: Font.Weight
        public let color: Color

        public init(font: Font, fontWeight: Font.Weight, color: Color) {
            self.font = font
            self.fontWeight = fontWeight
            self.color = color
        }
    }
}
