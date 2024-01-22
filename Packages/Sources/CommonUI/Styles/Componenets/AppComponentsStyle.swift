//
//  AppComponentsStyle.swift
//  Dynamic Styling POC
//

import Foundation

public struct AppComponentsStyles: Equatable, Codable {
    public let text: [String: AppTextStyle]
}

public struct AppTextStyle: Equatable, Codable {
    public let font: String
    public let color: String
}

public extension [String: AppTextStyle] {
    static func makeDefault(designSystem: AppDesignSystem) -> [String: AppTextStyle] {
        [
            AppTextType.title.rawValue: AppTextStyle(font: "title", color: "text500"),
            AppTextType.subtitle.rawValue: AppTextStyle(font: "subtitle", color: "text500"),
            AppTextType.text.rawValue: AppTextStyle(font: "text", color: "text500"),
        ]
    }
}

public extension AppComponentsStyles {
    static func makeDefault(designSystem: AppDesignSystem) -> AppComponentsStyles {
        // TODO: Define component styles!!!
        AppComponentsStyles(
            text: .makeDefault(designSystem: designSystem)
        )
    }
}

public struct AppComponentsStylesUpdate: Equatable, Codable {
    public let text: [String: AppTextStyleUpdate]?
}

public struct AppTextStyleUpdate: Equatable, Codable {
    public let font: String?
    public let color: String?
}
