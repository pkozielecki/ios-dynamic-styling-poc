//
//  AppFonts.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppFonts: Equatable {
    public let title: Font
    public let subtitle: Font
    public let text: Font

    public init(title: Font, subtitle: Font, text: Font) {
        self.title = title
        self.subtitle = subtitle
        self.text = text
    }

    func merging(with fontsUpdate: AppFontsUpdate?) -> AppFonts {
        AppFonts(
            title: fontsUpdate?.title ?? title,
            subtitle: fontsUpdate?.subtitle ?? subtitle,
            text: fontsUpdate?.text ?? text
        )
    }
}

public extension AppFonts {
    static var `default`: AppFonts {
        AppFonts(
            title: .largeTitle,
            subtitle: .title2,
            text: .body
        )
    }
}

public struct AppFontsUpdate: Equatable {
    public let title: Font?
    public let subtitle: Font?
    public let text: Font?

    // TODO: Initialize from json.
}
