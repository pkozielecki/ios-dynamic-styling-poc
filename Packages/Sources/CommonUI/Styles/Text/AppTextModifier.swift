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
            .font(styleGuide.font.font)
            .foregroundColor(styleGuide.color.color)
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
        public let font: AppFont
        public let color: AppColor

        public init(font: AppFont, color: AppColor) {
            self.font = font
            self.color = color
        }
    }

    struct StyleGuideUpdate: Equatable, Codable {
        public let font: AppFont?
        public let color: AppColor?

        public init(font: AppFont?, color: AppColor?) {
            self.font = font
            self.color = color
        }
    }
}

public extension AppTextModifier.StyleGuide {
    func merging(with designUpdate: AppTextModifier.StyleGuideUpdate) -> AppTextModifier.StyleGuide {
        AppTextModifier.StyleGuide(
            font: designUpdate.font ?? font,
            color: designUpdate.color ?? color
        )
    }
}
