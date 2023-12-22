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
}
