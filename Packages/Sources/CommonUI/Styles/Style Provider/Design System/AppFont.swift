//
//  AppFont.swift
//  Dynamic Styling POC
//

import SwiftUI
import UIKit

public struct AppFont: Equatable, Codable {
    public let fontName: AppFont.Name
    public let fontSize: CGFloat
    public let fontWeight: AppFontWeight

    public init(fontName: AppFont.Name, fontSize: CGFloat, fontWeight: AppFontWeight) {
        self.fontName = fontName
        self.fontSize = fontSize
        self.fontWeight = fontWeight
    }
}

public extension AppFont {
    enum Name: String, Equatable, Codable {
        case inter = "Inter"
    }

    var font: Font {
        .custom("\(fontName.rawValue.capitalized)-\(fontWeight.rawValue.capitalized)", size: fontSize)
    }
}
