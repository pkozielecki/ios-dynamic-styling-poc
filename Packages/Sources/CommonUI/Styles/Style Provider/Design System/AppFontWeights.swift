//
//  AppFontWeights.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppFontWeights: Equatable {
    public let light: Font.Weight
    public let regular: Font.Weight
    public let semiBold: Font.Weight
    public let bold: Font.Weight
    public let heavy: Font.Weight

    public init(light: Font.Weight, regular: Font.Weight, semiBold: Font.Weight, bold: Font.Weight, heavy: Font.Weight) {
        self.light = light
        self.regular = regular
        self.semiBold = semiBold
        self.bold = bold
        self.heavy = heavy
    }
}

public extension AppFontWeights {
    static var `default`: AppFontWeights {
        AppFontWeights(
            light: .light,
            regular: .regular,
            semiBold: .semibold,
            bold: .bold,
            heavy: .heavy
        )
    }
}
