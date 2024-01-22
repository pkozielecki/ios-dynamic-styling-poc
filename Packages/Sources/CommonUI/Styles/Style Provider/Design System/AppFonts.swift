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
    enum Names: String, Equatable, Codable {
        case inter = "Inter"
    }

    static var `default`: AppFonts {
        AppFonts(
            title: .init(fontName: AppFonts.Names.inter, fontSize: 22, fontWeight: .black),
            subtitle: .init(fontName: AppFonts.Names.inter, fontSize: 16, fontWeight: .bold),
            text: .init(fontName: AppFonts.Names.inter, fontSize: 14, fontWeight: .regular)
        )
    }
}

public struct AppFontsUpdate: Equatable, Codable {
    public let title: AppFont?
    public let subtitle: AppFont?
    public let text: AppFont?
}
