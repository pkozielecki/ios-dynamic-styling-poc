//
//  AppFonts.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppFonts: Equatable {
    // TODO: Add more fonts
    public let title: Font
    public let subtitle: Font
    public let text: Font

    public init(title: Font, subtitle: Font, text: Font) {
        self.title = title
        self.subtitle = subtitle
        self.text = text
    }
}

public extension AppFonts {
    static var `default`: AppFonts {
        AppFonts(
            title: .title,
            subtitle: .title2,
            text: .body
        )
    }
}
