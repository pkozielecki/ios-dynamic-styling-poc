//
//  AppStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppStyle: Equatable {
    public private(set) var buttonStyles: [AppButtonType: AppButtonStyle]
    public private(set) var textStyles: [AppTextType: AppTextModifier.StyleGuide]
    public private(set) var textFieldStyles: [AppTextFieldType: AppTextFieldStyle]

    private var initialDesignSystem: AppDesignSystem

    public init(initialDesignSystem: AppDesignSystem) {
        self.initialDesignSystem = initialDesignSystem
        buttonStyles = AppStyle.composeInitialButtonStyles(designSystem: initialDesignSystem)
        textStyles = AppStyle.composeInitialAppTextStyles(designSystem: initialDesignSystem)
        textFieldStyles = AppStyle.composeInitialAppTextFieldStyles(designSystem: initialDesignSystem)
    }

    public mutating func update(with appStyle: AppStyle?, and designSystem: DesignSystemUpdate) {
        // TODO: Implement proper styles merge.
        let newDesignSystem = initialDesignSystem.merging(with: designSystem)
        buttonStyles = AppStyle.composeInitialButtonStyles(designSystem: newDesignSystem)
        textStyles = AppStyle.composeInitialAppTextStyles(designSystem: newDesignSystem)
        textFieldStyles = AppStyle.composeInitialAppTextFieldStyles(designSystem: newDesignSystem)
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
    static func composeInitialButtonStyles(designSystem: AppDesignSystem) -> [AppButtonType: AppButtonStyle] {
        var styles = [AppButtonType: AppButtonStyle]()
        for buttonType in AppButtonType.allCases {
            let styleGuide = makeInitialButtonStyleGuide(buttonType: buttonType, designSystem: designSystem)
            styles[buttonType] = AppButtonStyle(styleGuide: styleGuide)
        }
        return styles
    }

    static func composeInitialAppTextStyles(designSystem: AppDesignSystem) -> [AppTextType: AppTextModifier.StyleGuide] {
        var styles = [AppTextType: AppTextModifier.StyleGuide]()
        for textType in AppTextType.allCases {
            styles[textType] = makeInitialTextStyleGuide(appTextType: textType, designSystem: designSystem)
        }
        return styles
    }

    static func composeInitialAppTextFieldStyles(designSystem: AppDesignSystem) -> [AppTextFieldType: AppTextFieldStyle] {
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

    static func makeInitialTextStyleGuide(appTextType: AppTextType, designSystem: AppDesignSystem) -> AppTextModifier.StyleGuide {
        switch appTextType {
        case .title:
            AppTextModifier.StyleGuide(
                font: designSystem.fonts.title.font,
                fontWeight: designSystem.fontWights.heavy,
                color: designSystem.colors.text500.color ?? .clear
            )
        case .subtitle:
            AppTextModifier.StyleGuide(
                font: designSystem.fonts.subtitle.font,
                fontWeight: designSystem.fontWights.bold,
                color: designSystem.colors.text500.color ?? .clear
            )
        case .text:
            AppTextModifier.StyleGuide(
                font: designSystem.fonts.text.font,
                fontWeight: designSystem.fontWights.regular,
                color: designSystem.colors.text500.color ?? .clear
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
