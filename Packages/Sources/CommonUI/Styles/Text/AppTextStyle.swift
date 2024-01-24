//
//  AppTextStyle.swift
//  Dynamic Styling POC
//

import Foundation

public struct AppTextStyle: Equatable, Codable {
    public let font: String
    public let color: String
}

public extension [String: AppTextStyle] {
    static var `default`: [String: AppTextStyle] {
        [
            AppTextType.title.rawValue: AppTextStyle(font: "title", color: "text500"),
            AppTextType.subtitle.rawValue: AppTextStyle(font: "subtitle", color: "text500"),
            AppTextType.text.rawValue: AppTextStyle(font: "text", color: "text500"),
        ]
    }
}
