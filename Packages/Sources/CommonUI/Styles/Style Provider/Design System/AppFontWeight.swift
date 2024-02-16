//
//  AppFontWeight.swift
//  Dynamic Styling POC
//

import SwiftUI

public enum AppFontWeight: String, Equatable, Codable, CaseIterable, Hashable, RawRepresentable {
    case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
}

public extension AppFontWeight {
    var fontWeight: Font.Weight {
        switch self {
        case .ultraLight:
            .ultraLight
        case .thin:
            .thin
        case .light:
            .light
        case .regular:
            .regular
        case .medium:
            .medium
        case .semibold:
            .semibold
        case .bold:
            .bold
        case .black:
            .black
        default:
            .regular
        }
    }
}
