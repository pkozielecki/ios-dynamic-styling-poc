//
//  DesignSystemExtensions.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

public extension AppDesignSystem {
    static var `default`: AppDesignSystem {
        AppDesignSystem(
            colors: .default,
            fonts: .default
        )
    }
}

public extension AppColors {
    static var `default`: AppColors {
        AppColors(
            error500: .init(named: "Error500"),
            informative500: .init(named: "Informative500"),
            neutral500: .init(named: "Neutral500"),
            primary100: .init(named: "Primary100"),
            primary500: .init(named: "Primary500"),
            primary900: .init(named: "Primary900"),
            secondary100: .init(named: "Secondary100"),
            secondary500: .init(named: "Secondary500"),
            secondary900: .init(named: "Secondary900"),
            success500: .init(named: "Success500"),
            tertiary100: .init(named: "Tertiary100"),
            text500: .init(named: "Text500"),
            warning500: .init(named: "Warning500"),
            clear: .init(light: .clear, dark: .clear)
        )
    }
}
