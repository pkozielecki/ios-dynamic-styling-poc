//
//  AppComponentsStyle.swift
//  Dynamic Styling POC
//

import UIKit

public struct AppComponentsStyles: Equatable, Codable {
    public let text: [String: AppTextStyle]
    public let button: [String: AppButtonStyle]
    public let textField: [String: AppTextFieldStyle]

    public init(text: [String: AppTextStyle], button: [String: AppButtonStyle], textField: [String: AppTextFieldStyle]) {
        self.text = text
        self.button = button
        self.textField = textField
    }
}

public extension AppComponentsStyles {
    static var `default`: AppComponentsStyles {
        AppComponentsStyles(
            text: .default,
            button: .default,
            textField: .default
        )
    }
}
