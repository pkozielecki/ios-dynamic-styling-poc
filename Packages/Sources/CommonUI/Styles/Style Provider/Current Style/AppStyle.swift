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
        textStyles = AppTextStyleFactory.composeAppTextStyles(components: components, designSystem: designSystem)
        buttonStyles = AppButtonStyleFactory.composeAppButtonStyles(components: components, designSystem: designSystem)
        textFieldStyles = AppTextFieldStyleFactory.composeAppTextFieldStyles(components: components, designSystem: designSystem)
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
        textStyles = AppTextStyleFactory.composeAppTextStyles(components: components, designSystem: designSystem)
        buttonStyles = AppButtonStyleFactory.composeAppButtonStyles(components: components, designSystem: initialDesignSystem)
        textFieldStyles = AppTextFieldStyleFactory.composeAppTextFieldStyles(components: components, designSystem: initialDesignSystem)
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
