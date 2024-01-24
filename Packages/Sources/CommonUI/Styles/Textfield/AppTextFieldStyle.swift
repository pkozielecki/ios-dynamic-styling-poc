//
//  AppTextFieldStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppTextFieldStyle: Codable, Equatable {
    public let shape: AppTextFieldShape
    public let backgroundColor: String
    public let textColor: String
    public let font: String
    public let padding: [CGFloat]
    public let keyboardType: Int
}

public extension AppTextFieldStyle {
    struct StyleGuide: Equatable {
        public let shape: AppTextFieldShape
        public let backgroundColor: AppColor
        public let textColor: AppColor
        public let font: AppFont
        public let padding: EdgeInsets
        public let keyboardType: UIKeyboardType

        public init(
            shape: AppTextFieldShape,
            backgroundColor: AppColor,
            textColor: AppColor,
            font: AppFont,
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

extension AppTextFieldStyle.StyleGuide: TextFieldStyle {
    public func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(padding)
            .background(makeBackgroundView())
            .keyboardType(keyboardType)
            .font(font.font)
    }
}

extension AppTextFieldStyle.StyleGuide {
    @ViewBuilder func makeBackgroundView() -> some View {
        switch shape {
        case .rounded(let radius):
            RoundedRectangle(cornerRadius: radius).fill(backgroundColor.color ?? .clear)
        case .plain:
            Color.clear
        }
    }
}
