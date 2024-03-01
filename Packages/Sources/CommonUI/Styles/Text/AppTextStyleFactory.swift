//
//  AppTextStyleFactory.swift
//  Dynamic Styling POC
//

import Foundation

enum AppTextStyleFactory {
    static func composeAppTextStyles(components: AppComponentsStyles, designSystem: AppDesignSystem) -> [AppTextType: AppTextModifier.StyleGuide] {
        var styles = [AppTextType: AppTextModifier.StyleGuide]()
        for (textName, textStyle) in components.text {
            if let textType = AppTextType(rawValue: textName) {
                styles[textType] = makeTextStyleGuide(appTextType: textType, colorName: textStyle.color, designSystem: designSystem)
            }
        }
        return styles
    }
}

private extension AppTextStyleFactory {
    static func makeTextStyleGuide(appTextType: AppTextType, colorName: String, designSystem: AppDesignSystem) -> AppTextModifier.StyleGuide {
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
        case .error:
            return AppTextModifier.StyleGuide(
                font: font ?? designSystem.fonts.text,
                color: color ?? designSystem.colors.error500
            )
        }
    }
}
