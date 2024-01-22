//
//  AppFont.swift
//  Dynamic Styling POC
//

import SwiftUI
import UIKit

public struct AppFont: Equatable, Codable {
    public let fontName: AppFonts.Names
    public let fontSize: CGFloat
    public let fontWeight: AppFontWeight

    public init(fontName: AppFonts.Names, fontSize: CGFloat, fontWeight: AppFontWeight) {
        self.fontName = fontName
        self.fontSize = fontSize
        self.fontWeight = fontWeight
    }
}

public extension AppFont {
    var font: Font {
        .custom("\(fontName.rawValue.capitalized)-\(fontWeight.rawValue.capitalized)", size: fontSize)
    }
}
