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
        buttonStyles = AppStyle.composeButtonStyles(designSystem: initialDesignSystem)
        textStyles = AppStyle.composeAppTextStyles(designSystem: initialDesignSystem)
        textFieldStyles = AppStyle.composeAppTextFieldStyles(designSystem: initialDesignSystem)
    }

    public mutating func update(with appStyleUpdate: AppStyleUpdate?) {
        if let designSystem = appStyleUpdate?.designSystem {
            let newDesignSystem = initialDesignSystem.merging(with: designSystem)
            buttonStyles = AppStyle.composeButtonStyles(designSystem: newDesignSystem)
            textStyles = AppStyle.composeAppTextStyles(designSystem: newDesignSystem)
            textFieldStyles = AppStyle.composeAppTextFieldStyles(designSystem: newDesignSystem)
        }
        /*
         if let componentStyles = appStyleUpdate?.components {
             for textStyle in componentStyles.text ?? [] {
                 textStyle[textStyle.type].update(from: textStyle)
             }
             for textName in AppTextType.allCases {
                 var currentStyle = textStyles[textName]
             }
         }
          */
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

    static func composeAppTextStyles(designSystem: AppDesignSystem) -> [AppTextType: AppTextModifier.StyleGuide] {
        var styles = [AppTextType: AppTextModifier.StyleGuide]()
        for textType in AppTextType.allCases {
            styles[textType] = makeInitialTextStyleGuide(appTextType: textType, designSystem: designSystem)
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

    static func makeInitialTextStyleGuide(appTextType: AppTextType, designSystem: AppDesignSystem) -> AppTextModifier.StyleGuide {
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
