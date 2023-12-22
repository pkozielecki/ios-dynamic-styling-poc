//
//  AppLabelStyle.swift
//  Dynamic Styling POC
//

import Common
import SwiftUI

public struct AppLabelStyle: LabelStyle, Equatable {
    public let styleGuide: StyleGuide

    public init(styleGuide: StyleGuide) {
        self.styleGuide = styleGuide
    }

    public func makeBody(configuration: AppLabelStyle.Configuration) -> some View {
        configuration.title
            .font(styleGuide.font.weight(styleGuide.fontWeight))
            .foregroundColor(styleGuide.color)
    }
}

public extension AppLabelStyle {
    struct StyleGuide: Equatable {
        // TODO: Add font decoration
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
