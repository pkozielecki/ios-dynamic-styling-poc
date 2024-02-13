//
//  AppFonts.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppFonts: Equatable, Codable {
    public let title: AppFont
    public let subtitle: AppFont
    public let text: AppFont

    public init(title: AppFont, subtitle: AppFont, text: AppFont) {
        self.title = title
        self.subtitle = subtitle
        self.text = text
    }
}

public extension AppFonts {
    static var `default`: AppFonts {
        AppFonts(
            title: .init(fontName: AppFont.Name.inter, fontSize: 22, fontWeight: .black),
            subtitle: .init(fontName: AppFont.Name.inter, fontSize: 18, fontWeight: .bold),
            text: .init(fontName: AppFont.Name.inter, fontSize: 14, fontWeight: .regular)
        )
    }

    func getFont(textType: AppTextType) -> AppFont? {
        switch textType {
        case .title:
            title
        case .subtitle:
            subtitle
        case .text:
            text
        }
    }

    func getFont(textFieldType: AppTextFieldType) -> AppFont? {
        switch textFieldType {
        case .email:
            text
        case .password:
            text
        }
    }
}
