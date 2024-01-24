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
}
