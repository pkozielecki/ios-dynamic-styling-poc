//
//  AppButtonStyleFactory.swift
//  Dynamic Styling POC
//

import Foundation

enum AppButtonStyleFactory {
    static func composeAppButtonStyles(
        components: AppComponentsStyles,
        designSystem: AppDesignSystem
    ) -> [AppButtonType: AppButtonStyle.StyleGuide] {
        var styles = [AppButtonType: AppButtonStyle.StyleGuide]()
        for (buttonName, buttonStyle) in components.button {
            if let buttonType = AppButtonType(rawValue: buttonName) {
                styles[buttonType] = makeInitialButtonStyleGuide(
                    buttonType: buttonType,
                    buttonStyle: buttonStyle,
                    designSystem: designSystem
                )
            }
        }
        return styles
    }
}

private extension AppButtonStyleFactory {
    static func makeInitialButtonStyleGuide(
        buttonType: AppButtonType,
        buttonStyle: AppButtonStyle,
        designSystem: AppDesignSystem
    ) -> AppButtonStyle.StyleGuide {
        let shape = buttonStyle.shape
        let backgroundColor = designSystem.colors.getColor(named: buttonStyle.backgroundColor)
        let textColor = designSystem.colors.getColor(named: buttonStyle.textColor)
        let padding = buttonStyle.padding
        switch buttonType {
        case .primary:
            return AppButtonStyle.StyleGuide(
                shape: shape,
                backgroundColor: backgroundColor ?? designSystem.colors.primary500,
                textColor: textColor ?? designSystem.colors.text500,
                padding: padding.edgeInsets
            )
        case .secondary:
            return AppButtonStyle.StyleGuide(
                shape: shape,
                backgroundColor: backgroundColor ?? designSystem.colors.clear,
                textColor: textColor ?? designSystem.colors.primary500,
                padding: padding.edgeInsets
            )
        }
    }
}
