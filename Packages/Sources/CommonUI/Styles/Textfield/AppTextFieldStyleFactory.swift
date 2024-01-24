//
//  AppTextFieldStyleFactory.swift
//  Dynamic Styling POC
//

import UIKit

enum AppTextFieldStyleFactory {
    static func composeAppTextFieldStyles(components: AppComponentsStyles, designSystem: AppDesignSystem) -> [AppTextFieldType: AppTextFieldStyle.StyleGuide] {
        var styles = [AppTextFieldType: AppTextFieldStyle.StyleGuide]()
        for (textFieldName, textFieldStyle) in components.textField {
            if let textFieldType = AppTextFieldType(rawValue: textFieldName) {
                styles[textFieldType] = makeTextFieldStyleGuide(textFieldType: textFieldType, textFieldStyle: textFieldStyle, designSystem: designSystem)
            }
        }
        return styles
    }
}

private extension AppTextFieldStyleFactory {
    static func makeTextFieldStyleGuide(textFieldType: AppTextFieldType, textFieldStyle: AppTextFieldStyle, designSystem: AppDesignSystem) -> AppTextFieldStyle.StyleGuide {
        let shape = textFieldStyle.shape
        let backgroundColor = designSystem.colors.getColor(named: textFieldStyle.backgroundColor)
        let textColor = designSystem.colors.getColor(named: textFieldStyle.textColor)
        let font = designSystem.fonts.getFont(textFieldType: textFieldType)
        let padding = textFieldStyle.padding
        let keyboardType = UIKeyboardType(rawValue: textFieldStyle.keyboardType) ?? .default
        switch textFieldType {
        case .email:
            return AppTextFieldStyle.StyleGuide(
                shape: shape,
                backgroundColor: backgroundColor ?? designSystem.colors.primary900,
                textColor: textColor ?? designSystem.colors.text500,
                font: font ?? designSystem.fonts.text,
                padding: padding.edgeInsets,
                keyboardType: keyboardType
            )
        case .password:
            return AppTextFieldStyle.StyleGuide(
                shape: shape,
                backgroundColor: designSystem.colors.primary500,
                textColor: designSystem.colors.secondary500,
                font: font ?? designSystem.fonts.text,
                padding: padding.edgeInsets,
                keyboardType: keyboardType
            )
        }
    }
}
