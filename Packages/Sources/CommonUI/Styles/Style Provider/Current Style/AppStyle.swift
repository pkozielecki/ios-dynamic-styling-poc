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
    private(set) var textFieldStyles: [AppTextFieldType: AppTextFieldStyle]

    private enum CodingKeys: String, CodingKey {
        case designSystem, components
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        designSystem = try container.decode(AppDesignSystem.self, forKey: .designSystem)
        components = try container.decode(AppComponentsStyles.self, forKey: .components)
        textStyles = AppStyle.composeAppTextStyles(components: components, designSystem: designSystem)
        buttonStyles = AppStyle.composeButtonStyles(components: components, designSystem: designSystem)
        // TODO: Transform the rest:
        textFieldStyles = AppStyle.composeAppTextFieldStyles(designSystem: designSystem)
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
        buttonStyles = AppStyle.composeButtonStyles(components: components, designSystem: initialDesignSystem)
        // TODO: Transform the rest:
        textFieldStyles = AppStyle.composeAppTextFieldStyles(designSystem: initialDesignSystem)
    }
}

public extension AppStyle {
    func getButtonStyle(for buttonType: AppButtonType) -> AppButtonStyle.StyleGuide? {
        buttonStyles[buttonType]
    }

    func getTextStyle(for labelType: AppTextType) -> AppTextModifier.StyleGuide? {
        textStyles[labelType]
    }

    func getTextFieldStyle(for textFieldType: AppTextFieldType) -> AppTextFieldStyle? {
        textFieldStyles[textFieldType]
    }
}

private extension AppStyle {
    static func composeButtonStyles(components: AppComponentsStyles, designSystem: AppDesignSystem) -> [AppButtonType: AppButtonStyle.StyleGuide] {
        var styles = [AppButtonType: AppButtonStyle.StyleGuide]()
        // TODO: Get button styles from components:
        for buttonType in AppButtonType.allCases {
            styles[buttonType] = makeInitialButtonStyleGuide(buttonType: buttonType, designSystem: designSystem)
        }
        return styles
    }

    static func composeAppTextStyles(components: AppComponentsStyles, designSystem: AppDesignSystem) -> [AppTextType: AppTextModifier.StyleGuide] {
        var styles = [AppTextType: AppTextModifier.StyleGuide]()
        for (key, value) in components.text {
            if let textType = AppTextType(rawValue: key) {
                styles[textType] = makeTextStyleGuide(appTextType: textType, colorName: value.color, designSystem: designSystem)
            }
        }
        return styles
    }

    static func composeAppTextFieldStyles(designSystem: AppDesignSystem) -> [AppTextFieldType: AppTextFieldStyle] {
        var styles = [AppTextFieldType: AppTextFieldStyle]()
        for textFiledType in AppTextFieldType.allCases {
            let styleGuide = makeInitialTextFieldStyleGuide(appTextFieldType: textFiledType, designSystem: designSystem)
            styles[textFiledType] = AppTextFieldStyle(styleGuide: styleGuide)
        }
        return styles
    }

    static func makeInitialButtonStyleGuide(buttonType: AppButtonType, designSystem: AppDesignSystem) -> AppButtonStyle.StyleGuide {
        switch buttonType {
        case .primary:
            AppButtonStyle.StyleGuide(
                shape: .capsule,
                backgroundColor: designSystem.colors.primary500,
                textColor: designSystem.colors.text500,
                padding: .init(top: 15, leading: 30, bottom: 15, trailing: 30) // TODO: Get padding from Design System
            )
        case .secondry:
            AppButtonStyle.StyleGuide(
                shape: .default,
                backgroundColor: designSystem.colors.clear,
                textColor: designSystem.colors.primary500,
                padding: .init(top: 10, leading: 10, bottom: 10, trailing: 10) // TODO: Get padding from Design System
            )
        }
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

    static func makeInitialTextFieldStyleGuide(appTextFieldType: AppTextFieldType, designSystem: AppDesignSystem) -> AppTextFieldStyle.StyleGuide {
        switch appTextFieldType {
        case .email:
            AppTextFieldStyle.StyleGuide(
                shape: .rounded(10),
                backgroundColor: designSystem.colors.primary900.color ?? .clear,
                textColor: designSystem.colors.text500.color ?? .clear,
                font: designSystem.fonts.text.font,
                padding: .init(top: 10, leading: 10, bottom: 10, trailing: 10), // TODO: Get padding from Design System
                keyboardType: .emailAddress
            )
        case .password:
            AppTextFieldStyle.StyleGuide(
                shape: .rounded(10),
                backgroundColor: designSystem.colors.primary500.color ?? .clear,
                textColor: designSystem.colors.secondary500.color ?? .clear,
                font: designSystem.fonts.text.font,
                padding: .init(top: 10, leading: 10, bottom: 10, trailing: 10), // TODO: Get padding from Design System
                keyboardType: .default
            )
        }
    }
}
