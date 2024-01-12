//
//  DesignSystem.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct DesignSystem: Equatable {
    public let colors: AppColors
    public let fonts: AppFonts
    public let fontWights: AppFontWeights

    public init(colors: AppColors, fonts: AppFonts, fontWights: AppFontWeights) {
        self.colors = colors
        self.fonts = fonts
        self.fontWights = fontWights
    }

    public func merging(with designUpdate: DesignSystemUpdate) -> DesignSystem {
        // TODO: Implement merging fonts and font weights.
        DesignSystem(
            colors: colors.merging(with: designUpdate.colors),
            fonts: fonts,
            fontWights: fontWights
        )
    }
}

public struct DesignSystemUpdate: Equatable {
    public let colors: AppColorsUpdate?
    public let fonts: AppFonts?
    public let fontWights: AppFontWeights?
}
