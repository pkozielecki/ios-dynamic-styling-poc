//
//  AppComponentsStyle.swift
//  Dynamic Styling POC
//

import UIKit

public struct AppComponentsStyles: Equatable, Codable {
    public let text: [String: AppTextStyle]
    public let button: [String: AppButtonStyle]
    public let textField: [String: AppTextFieldStyle]
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
