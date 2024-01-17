//
//  AppFontWeights.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppFontWeights: Equatable {
    public let light: AppFontWeight
    public let regular: AppFontWeight
    public let semiBold: AppFontWeight
    public let bold: AppFontWeight
    public let heavy: AppFontWeight

    public init(light: AppFontWeight, regular: AppFontWeight, semiBold: AppFontWeight, bold: AppFontWeight, heavy: AppFontWeight) {
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
            light: AppFontWeight.light,
            regular: AppFontWeight.regular,
            semiBold: AppFontWeight.semibold,
            bold: AppFontWeight.bold,
            heavy: AppFontWeight.heavy
        )
    }
}
