//
//  TestDesignSystem.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import SwiftUI

public extension AppComponentsStyles {
    static var test: AppComponentsStyles {
        AppComponentsStyles(
            text: .test,
            button: .test,
            textField: .test
        )
    }
}

public extension AppDesignSystem {
    static var test: AppDesignSystem {
        AppDesignSystem(
            colors: .test,
            fonts: .default
        )
    }
}

public extension AppColors {
    static var test: AppColors {
        AppColors(
            error500: UIColor(Color("Error500", bundle: Bundle.module)),
            informative500: UIColor(Color("Informative500", bundle: Bundle.module)),
            neutral500: UIColor(Color("Neutral500", bundle: Bundle.module)),
            primary100: UIColor(Color("Primary100", bundle: Bundle.module)),
            primary500: UIColor(Color("Primary500", bundle: Bundle.module)),
            primary900: UIColor(Color("Primary900", bundle: Bundle.module)),
            secondary100: UIColor(Color("Secondary100", bundle: Bundle.module)),
            secondary500: UIColor(Color("Secondary500", bundle: Bundle.module)),
            secondary900: UIColor(Color("Secondary900", bundle: Bundle.module)),
            success500: UIColor(Color("Success500", bundle: Bundle.module)),
            tertiary100: UIColor(Color("Tertiary100", bundle: Bundle.module)),
            text500: UIColor(Color("Text500", bundle: Bundle.module)),
            warning500: UIColor(Color("Warning500", bundle: Bundle.module)),
            clear: .clear
        )
    }
}

public extension [String: AppTextStyle] {
    static var test: [String: AppTextStyle] {
        [
            AppTextType.title.rawValue: AppTextStyle(font: "title", color: "text500"),
            AppTextType.subtitle.rawValue: AppTextStyle(font: "subtitle", color: "text500"),
            AppTextType.text.rawValue: AppTextStyle(font: "text", color: "text500"),
            AppTextType.error.rawValue: AppTextStyle(font: "text", color: "error500"),
        ]
    }
}

public extension [String: AppButtonStyle] {
    static var test: [String: AppButtonStyle] {
        [
            AppButtonType.primary.rawValue: AppButtonStyle(shape: .capsule, backgroundColor: "text500", textColor: "primary500", padding: [15, 30, 15, 30]),
            AppButtonType.secondary.rawValue: AppButtonStyle(shape: .default, backgroundColor: "clear", textColor: "primary500", padding: [10, 10, 10, 10]),
        ]
    }
}

public extension [String: AppTextFieldStyle] {
    static var test: [String: AppTextFieldStyle] {
        [
            AppTextFieldType.email.rawValue: AppTextFieldStyle(
                shape: .rounded(cornerRadius: 10),
                backgroundColor: "primary900",
                textColor: "text500",
                font: "text",
                padding: [10, 10, 10, 10],
                keyboardType: UIKeyboardType.emailAddress.rawValue
            ),
            AppTextFieldType.password.rawValue: AppTextFieldStyle(
                shape: .rounded(cornerRadius: 10),
                backgroundColor: "primary500",
                textColor: "secondary500",
                font: "text",
                padding: [10, 10, 10, 10],
                keyboardType: UIKeyboardType.default.rawValue
            ),
        ]
    }
}
