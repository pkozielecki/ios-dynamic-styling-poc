//
//  AppDesignSystem.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppDesignSystem: Equatable {
    public let colors: AppColors
    public let fonts: AppFonts

    public init(colors: AppColors, fonts: AppFonts) {
        self.colors = colors
        self.fonts = fonts
    }

    public func merging(with designUpdate: DesignSystemUpdate) -> AppDesignSystem {
        // TODO: Implement merging fonts and font weights.
        AppDesignSystem(
            colors: colors.merging(with: designUpdate.colors),
            fonts: fonts.merging(with: designUpdate.fonts)
        )
    }
}

public struct DesignSystemUpdate: Equatable {
    public let colors: AppColorsUpdate?
    public let fonts: AppFontsUpdate?
}
