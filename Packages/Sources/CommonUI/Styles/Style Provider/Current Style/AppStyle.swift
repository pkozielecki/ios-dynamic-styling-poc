//
//  AppStyle.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppStyle: Equatable {
    public private(set) var buttonStyles: [AppButtonType: AppButtonStyle]
    public private(set) var labelStyles: [AppLabelType: AppLabelStyle]

    public init(initialDesignSystem: DesignSystem) {
        buttonStyles = AppStyle.composeInitialButtonStyles(designSystem: initialDesignSystem)
        labelStyles = AppStyle.composeInitialAppLabelStyles(designSystem: initialDesignSystem)
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

    static func composeInitialAppLabelStyles(designSystem: DesignSystem) -> [AppLabelType: AppLabelStyle] {
        var styles = [AppLabelType: AppLabelStyle]()
        for buttonType in AppLabelType.allCases {
            let styleGuide = makeInitialLabelStyleGuide(appLabelType: buttonType, designSystem: designSystem)
            styles[buttonType] = AppLabelStyle(styleGuide: styleGuide)
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

    static func makeInitialLabelStyleGuide(appLabelType: AppLabelType, designSystem: DesignSystem) -> AppLabelStyle.StyleGuide {
        switch appLabelType {
        case .title:
            AppLabelStyle.StyleGuide(
                font: designSystem.fonts.title,
                fontWeight: designSystem.fontWights.heavy,
                color: designSystem.colors.text500
            )
        case .subtitle:
            AppLabelStyle.StyleGuide(
                font: designSystem.fonts.subtitle,
                fontWeight: designSystem.fontWights.bold,
                color: designSystem.colors.text500
            )
        case .text:
            AppLabelStyle.StyleGuide(
                font: designSystem.fonts.text,
                fontWeight: designSystem.fontWights.regular,
                color: designSystem.colors.text500
            )
        }
    }
}