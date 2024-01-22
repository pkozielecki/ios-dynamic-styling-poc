//
//  AppStyleUpdate.swift
//  Dynamic Styling POC
//

import Foundation

public struct AppStyleUpdate: Equatable, Codable {
    public let designSystem: DesignSystemUpdate?
    public let components: AppComponentStylesUpdate?
}

public struct AppComponentStylesUpdate: Equatable, Codable {
    public let text: [AppTextStyleUpdate]?
}

public struct AppTextStyleUpdate: Equatable, Codable {
    public let type: AppTextType?
    public let fontName: String?
    public let colorName: String?
}
