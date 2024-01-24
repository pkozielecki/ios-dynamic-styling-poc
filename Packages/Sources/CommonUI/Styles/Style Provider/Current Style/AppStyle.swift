//
//  AppStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppStyle: Equatable, Codable {
    public let designSystem: AppDesignSystem
    public let components: AppComponentsStyles

    private(set) var buttonStyles: [AppButtonType: AppButtonStyle.StyleGuide]
    private(set) var textStyles: [AppTextType: AppTextModifier.StyleGuide]
    private(set) var textFieldStyles: [AppTextFieldType: AppTextFieldStyle.StyleGuide]

    private enum CodingKeys: String, CodingKey {
        case designSystem, components
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        designSystem = try container.decode(AppDesignSystem.self, forKey: .designSystem)
        components = try container.decode(AppComponentsStyles.self, forKey: .components)
        textStyles = AppStyle.composeAppTextStyles(components: components, designSystem: designSystem)
        buttonStyles = AppStyle.composeAppButtonStyles(components: components, designSystem: designSystem)
        textFieldStyles = AppStyle.composeAppTextFieldStyles(components: components, designSystem: designSystem)
    }

    // But we want to store `fullName` in the JSON anyhow
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(designSystem, forKey: .designSystem)
        try container.encode(components, forKey: .components)
    }

    public init(initialDesignSystem: AppDesignSystem, intialComponents: AppComponentsStyles) {
        designSystem = initialDesignSystem
        components = intialComponents
        textStyles = AppStyle.composeAppTextStyles(components: components, designSystem: designSystem)
        buttonStyles = AppStyle.composeAppButtonStyles(components: components, designSystem: initialDesignSystem)
        textFieldStyles = AppStyle.composeAppTextFieldStyles(components: components, designSystem: initialDesignSystem)
    }
}

public extension AppStyle {
    func getButtonStyle(for buttonType: AppButtonType) -> AppButtonStyle.StyleGuide? {
        buttonStyles[buttonType]
    }

    func getTextStyle(for labelType: AppTextType) -> AppTextModifier.StyleGuide? {
        textStyles[labelType]
    }

    func getTextFieldStyle(for textFieldType: AppTextFieldType) -> AppTextFieldStyle.StyleGuide? {
        textFieldStyles[textFieldType]
    }
}

private extension AppStyle {
    static func composeAppTextStyles(components: AppComponentsStyles, designSystem: AppDesignSystem) -> [AppTextType: AppTextModifier.StyleGuide] {
        var styles = [AppTextType: AppTextModifier.StyleGuide]()
        for (textName, textStyle) in components.text {
            if let textType = AppTextType(rawValue: textName) {
                styles[textType] = makeTextStyleGuide(appTextType: textType, colorName: textStyle.color, designSystem: designSystem)
            }
        }
        return styles
    }

    static func composeAppButtonStyles(components: AppComponentsStyles, designSystem: AppDesignSystem) -> [AppButtonType: AppButtonStyle.StyleGuide] {
        var styles = [AppButtonType: AppButtonStyle.StyleGuide]()
        for (buttonName, buttonStyle) in components.button {
            if let buttonType = AppButtonType(rawValue: buttonName) {
                styles[buttonType] = makeInitialButtonStyleGuide(buttonType: buttonType, buttonStyle: buttonStyle, designSystem: designSystem)
            }
        }
        return styles
    }

    static func composeAppTextFieldStyles(components: AppComponentsStyles, designSystem: AppDesignSystem) -> [AppTextFieldType: AppTextFieldStyle.StyleGuide] {
        var styles = [AppTextFieldType: AppTextFieldStyle.StyleGuide]()
        for (textFieldName, textFieldStyle) in components.textField {
            if let textFieldType = AppTextFieldType(rawValue: textFieldName) {
                styles[textFieldType] = makeTextFieldStyleGuide(textFieldType: textFieldType, textFieldStyle: textFieldStyle, designSystem: designSystem)
            }
        }
        return styles
    }

    static func makeTextStyleGuide(appTextType: AppTextType, colorName: String, designSystem: AppDesignSystem) -> AppTextModifier.StyleGuide {
        // TODO: Extract to a dedicated factory:
        let font = designSystem.fonts.getFont(textType: appTextType)
        let color = designSystem.colors.getColor(named: colorName)
        switch appTextType {
        case .title:
            return AppTextModifier.StyleGuide(
                font: font ?? designSystem.fonts.title,
                color: color ?? designSystem.colors.text500
            )
        case .subtitle:
            return AppTextModifier.StyleGuide(
                font: font ?? designSystem.fonts.subtitle,
                color: color ?? designSystem.colors.text500
            )
        case .text:
            return AppTextModifier.StyleGuide(
                font: font ?? designSystem.fonts.text,
                color: color ?? designSystem.colors.text500
            )
        }
    }

    static func makeInitialButtonStyleGuide(buttonType: AppButtonType, buttonStyle: AppButtonStyle, designSystem: AppDesignSystem) -> AppButtonStyle.StyleGuide {
        // TODO: Extract to a dedicated factory:
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
        case .secondry:
            return AppButtonStyle.StyleGuide(
                shape: shape,
                backgroundColor: backgroundColor ?? designSystem.colors.clear,
                textColor: textColor ?? designSystem.colors.primary500,
                padding: padding.edgeInsets
            )
        }
    }

    static func makeTextFieldStyleGuide(textFieldType: AppTextFieldType, textFieldStyle: AppTextFieldStyle, designSystem: AppDesignSystem) -> AppTextFieldStyle.StyleGuide {
        // TODO: Extract to a dedicated factory:
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
