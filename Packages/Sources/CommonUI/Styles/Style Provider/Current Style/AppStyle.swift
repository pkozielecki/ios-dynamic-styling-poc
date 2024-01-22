//
//  AppStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppStyle: Equatable, Codable {
    public let designSystem: AppDesignSystem
    public let components: AppComponentsStyles

    private var buttonStyles: [AppButtonType: AppButtonStyle]
    private var textStyles: [AppTextType: AppTextModifier.StyleGuide]
    private var textFieldStyles: [AppTextFieldType: AppTextFieldStyle]

    private enum CodingKeys: String, CodingKey {
        case designSystem, components
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        designSystem = try container.decode(AppDesignSystem.self, forKey: .designSystem)
        components = try container.decode(AppComponentsStyles.self, forKey: .components)
        textStyles = AppStyle.composeAppTextStyles(components: components, designSystem: designSystem)
        // TODO: Transform the rest:
        buttonStyles = AppStyle.composeButtonStyles(designSystem: designSystem)
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
        // TODO: Transform the rest:
        buttonStyles = AppStyle.composeButtonStyles(designSystem: initialDesignSystem)
        textFieldStyles = AppStyle.composeAppTextFieldStyles(designSystem: initialDesignSystem)
    }

    public mutating func update(with appStyleUpdate: AppStyleUpdate?) {
        if let designSystemUpdate = appStyleUpdate?.designSystem {
            let newDesignSystem = designSystem.merging(with: designSystemUpdate)
            // TODO: Extract components from style and include them here:
            textStyles = AppStyle.composeAppTextStyles(components: components, designSystem: designSystem)
            // TODO: Merge merge components
            buttonStyles = AppStyle.composeButtonStyles(designSystem: newDesignSystem)
            textFieldStyles = AppStyle.composeAppTextFieldStyles(designSystem: newDesignSystem)
        }
    }
}

public extension AppStyle {
    func getButtonStyle(for buttonType: AppButtonType) -> AppButtonStyle? {
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
    static func composeButtonStyles(designSystem: AppDesignSystem) -> [AppButtonType: AppButtonStyle] {
        var styles = [AppButtonType: AppButtonStyle]()
        for buttonType in AppButtonType.allCases {
            let styleGuide = makeInitialButtonStyleGuide(buttonType: buttonType, designSystem: designSystem)
            styles[buttonType] = AppButtonStyle(styleGuide: styleGuide)
        }
        return styles
    }

    static func composeAppTextStyles(components: AppComponentsStyles, designSystem: AppDesignSystem) -> [AppTextType: AppTextModifier.StyleGuide] {
        var styles = [AppTextType: AppTextModifier.StyleGuide]()
        for (key, value) in components.text {
            if let textType = AppTextType(rawValue: key) {
                styles[textType] = makeInitialTextStyleGuide(appTextType: textType, textStyle: value, designSystem: designSystem)
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
                backgroundColor: designSystem.colors.primary500.color ?? .clear,
                textColor: designSystem.colors.text500.color ?? .clear,
                padding: .init(top: 15, leading: 30, bottom: 15, trailing: 30) // TODO: Get padding from Design System
            )
        case .secondry:
            AppButtonStyle.StyleGuide(
                shape: .default,
                backgroundColor: designSystem.colors.clear.color ?? .clear,
                textColor: designSystem.colors.primary500.color ?? .clear,
                padding: .init(top: 10, leading: 10, bottom: 10, trailing: 10) // TODO: Get padding from Design System
            )
        }
    }

    static func makeInitialTextStyleGuide(appTextType: AppTextType, textStyle: AppTextStyle, designSystem: AppDesignSystem) -> AppTextModifier.StyleGuide {
        switch appTextType {
        case .title:
            AppTextModifier.StyleGuide(
                font: designSystem.fonts.title,
                color: designSystem.colors.text500
            )
        case .subtitle:
            AppTextModifier.StyleGuide(
                font: designSystem.fonts.subtitle,
                color: designSystem.colors.text500
            )
        case .text:
            AppTextModifier.StyleGuide(
                font: designSystem.fonts.text,
                color: designSystem.colors.text500
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
