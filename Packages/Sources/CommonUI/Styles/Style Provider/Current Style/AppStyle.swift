//
//  AppStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppStyle: Equatable {
    public private(set) var buttonStyles: [AppButtonType: AppButtonStyle]
    public private(set) var textStyles: [AppTextType: AppTextModifier.StyleGuide]
    public private(set) var textFieldStyles: [AppTextFieldType: AppTextFieldStyle]

    public init(initialDesignSystem: DesignSystem) {
        buttonStyles = AppStyle.composeInitialButtonStyles(designSystem: initialDesignSystem)
        textStyles = AppStyle.composeInitialAppTextStyles(designSystem: initialDesignSystem)
        textFieldStyles = AppStyle.composeInitialAppTextFieldStyles(designSystem: initialDesignSystem)
    }

    public func update(with appStyle: AppStyle, and designSystem: DesignSystem) {
        // TODO: Update Design system.
        // TODO: Implement merging of styles
    }
}

private extension AppStyle {
    static func composeInitialButtonStyles(designSystem: DesignSystem) -> [AppButtonType: AppButtonStyle] {
        var styles = [AppButtonType: AppButtonStyle]()
        for buttonType in AppButtonType.allCases {
            let styleGuide = makeInitialButtonStyleGuide(buttonType: buttonType, designSystem: designSystem)
            styles[buttonType] = AppButtonStyle(styleGuide: styleGuide)
        }
        return styles
    }

    static func composeInitialAppTextStyles(designSystem: DesignSystem) -> [AppTextType: AppTextModifier.StyleGuide] {
        var styles = [AppTextType: AppTextModifier.StyleGuide]()
        for textType in AppTextType.allCases {
            styles[textType] = makeInitialTextStyleGuide(appTextType: textType, designSystem: designSystem)
        }
        return styles
    }

    static func composeInitialAppTextFieldStyles(designSystem: DesignSystem) -> [AppTextFieldType: AppTextFieldStyle] {
        var styles = [AppTextFieldType: AppTextFieldStyle]()
        for textFiledType in AppTextFieldType.allCases {
            let styleGuide = makeInitialTextFieldStyleGuide(appTextFieldType: textFiledType, designSystem: designSystem)
            styles[textFiledType] = AppTextFieldStyle(styleGuide: styleGuide)
        }
        return styles
    }

    static func makeInitialButtonStyleGuide(buttonType: AppButtonType, designSystem: DesignSystem) -> AppButtonStyle.StyleGuide {
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

    static func makeInitialTextStyleGuide(appTextType: AppTextType, designSystem: DesignSystem) -> AppTextModifier.StyleGuide {
        switch appTextType {
        case .title:
            AppTextModifier.StyleGuide(
                font: designSystem.fonts.title,
                fontWeight: designSystem.fontWights.heavy,
                color: designSystem.colors.text500
            )
        case .subtitle:
            AppTextModifier.StyleGuide(
                font: designSystem.fonts.subtitle,
                fontWeight: designSystem.fontWights.bold,
                color: designSystem.colors.text500
            )
        case .text:
            AppTextModifier.StyleGuide(
                font: designSystem.fonts.text,
                fontWeight: designSystem.fontWights.regular,
                color: designSystem.colors.text500
            )
        }
    }

    static func makeInitialTextFieldStyleGuide(appTextFieldType: AppTextFieldType, designSystem: DesignSystem) -> AppTextFieldStyle.StyleGuide {
        switch appTextFieldType {
        case .email:
            AppTextFieldStyle.StyleGuide(
                shape: .rounded(10),
                backgroundColor: designSystem.colors.primary900,
                textColor: designSystem.colors.text500,
                font: designSystem.fonts.text,
                padding: .init(top: 10, leading: 10, bottom: 10, trailing: 10), // TODO: Get padding from Design System
                keyboardType: .emailAddress
            )
        case .password:
            AppTextFieldStyle.StyleGuide(
                shape: .rounded(10),
                backgroundColor: designSystem.colors.primary500,
                textColor: designSystem.colors.secondary500,
                font: designSystem.fonts.text,
                padding: .init(top: 10, leading: 10, bottom: 10, trailing: 10), // TODO: Get padding from Design System
                keyboardType: .default
            )
        }
    }
}
