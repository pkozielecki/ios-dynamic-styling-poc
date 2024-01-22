//
//  AppDesignSystem.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppDesignSystem: Equatable, Codable {
    public let colors: AppColors
    public let fonts: AppFonts

    public init(colors: AppColors, fonts: AppFonts) {
        self.colors = colors
        self.fonts = fonts
    }

    public func merging(with designUpdate: AppDesignSystemUpdate) -> AppDesignSystem {
        AppDesignSystem(
            colors: colors.merging(with: designUpdate.colors),
            fonts: fonts.merging(with: designUpdate.fonts)
        )
    }
}

public struct AppDesignSystemUpdate: Equatable, Codable {
    public let colors: AppColorsUpdate?
    public let fonts: AppFontsUpdate?
}
