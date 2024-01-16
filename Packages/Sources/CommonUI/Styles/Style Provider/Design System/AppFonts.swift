//
//  AppFonts.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppFonts: Equatable {
    public let title: AppFont
    public let subtitle: AppFont
    public let text: AppFont

    public init(title: AppFont, subtitle: AppFont, text: AppFont) {
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
            title: .init(fontName: "System", fontSize: 20),
            subtitle: .init(fontName: "System", fontSize: 16),
            text: .init(fontName: "System", fontSize: 14)
        )
    }
}

public struct AppFontsUpdate: Equatable {
    public let title: AppFont?
    public let subtitle: AppFont?
    public let text: AppFont?
}
