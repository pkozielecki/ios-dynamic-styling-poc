//
//  AppTextFieldStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppTextFieldStyle: TextFieldStyle, Equatable {
    public let styleGuide: StyleGuide

    public init(styleGuide: StyleGuide) {
        self.styleGuide = styleGuide
    }

    public func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(styleGuide.padding)
            .background(makeBackgroundView())
            .keyboardType(styleGuide.keyboardType)
            .font(styleGuide.font)
    }
}

public extension AppTextFieldStyle {
    struct StyleGuide: Equatable {
        public let shape: AppTextFieldShape
        public let backgroundColor: Color
        public let textColor: Color
        public let font: Font
        public let padding: EdgeInsets
        public let keyboardType: UIKeyboardType

        public init(
            shape: AppTextFieldShape,
            backgroundColor: Color,
            textColor: Color,
            font: Font,
            padding: EdgeInsets,
            keyboardType: UIKeyboardType
        ) {
            self.shape = shape
            self.backgroundColor = backgroundColor
            self.textColor = textColor
            self.font = font
            self.padding = padding
            self.keyboardType = keyboardType
        }
    }
}

extension AppTextFieldStyle {
    @ViewBuilder func makeBackgroundView() -> some View {
        switch styleGuide.shape {
        case .rounded(let radius):
            RoundedRectangle(cornerRadius: radius).fill(styleGuide.backgroundColor)
        case .plain:
            Color.clear
        }
    }
}
