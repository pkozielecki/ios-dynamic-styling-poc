//
//  AppFont.swift
//  Dynamic Styling POC
//

import SwiftUI
import UIKit

public struct AppFont: Equatable, Codable {
    let fontName: String
    let fontSize: CGFloat

    public init(fontName: String, fontSize: CGFloat) {
        self.fontName = fontName
        self.fontSize = fontSize
    }
}

public extension AppFont {
    var font: Font {
        .custom(fontName, size: fontSize)
    }
}
