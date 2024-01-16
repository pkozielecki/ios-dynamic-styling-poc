//
//  AppDesignSystem.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppDesignSystem: Equatable {
    public let colors: AppColors
    public let fonts: AppFonts
    public let fontWights: AppFontWeights

    public init(colors: AppColors, fonts: AppFonts, fontWights: AppFontWeights) {
        self.colors = colors
        self.fonts = fonts
        self.fontWights = fontWights
    }

    public func merging(with designUpdate: DesignSystemUpdate) -> AppDesignSystem {
        // TODO: Implement merging fonts and font weights.
        AppDesignSystem(
            colors: colors.merging(with: designUpdate.colors),
            fonts: fonts.merging(with: designUpdate.fonts),
            fontWights: fontWights
        )
    }
}

public struct DesignSystemUpdate: Equatable {
    public let colors: AppColorsUpdate?
    public let fonts: AppFontsUpdate?
    public let fontWights: AppFontWeights?
}
