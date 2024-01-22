//
//  AppFontWeights.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppFontWeights: Equatable {
    public let light: AppFontWeight
    public let regular: AppFontWeight
    public let semibold: AppFontWeight
    public let bold: AppFontWeight
    public let heavy: AppFontWeight

    public init(light: AppFontWeight, regular: AppFontWeight, semibold: AppFontWeight, bold: AppFontWeight, heavy: AppFontWeight) {
        self.light = light
        self.regular = regular
        self.semibold = semibold
        self.bold = bold
        self.heavy = heavy
    }
}
