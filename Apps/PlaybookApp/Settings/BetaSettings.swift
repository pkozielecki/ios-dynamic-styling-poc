//
//  BetaSettings.swift
//  Dynamic Styling POC
//

import AutomaticSettings
import Common
import CommonUI
import Foundation
import SwiftUI

struct BetaSettings: AutomaticSettings {
    struct Colors: AutomaticSettings {
        var error500: String = "#F44336"
        var informative500: String = "#1890FF"
        var neutral500: String = "#9E9E9E"
        var primary100: String = "#F2E2F2"
        var primary500: String = "#900C90"
        var primary900: String = "#340434"
        var secondary100: String = "#E7F6FA"
        var secondary500: String = "#35B0D3"
        var secondary900: String = "#133F4C"
        var success500: String = "#4CAF50"
        var tertiary100: String = "#ED9D12"
        var text500: String = "#FDFDFD"
        var warning500: String = "#ED9D12"
        var clear: String = "#00000000"

        init() {}
    }

    struct TitleFont: AutomaticSettings {
        var fontName: String = "Inter"
        // sourcery: range = 5.0...100.0
        var fontSize: Float = 22.0
        var fontWeight: AppFontWeight = .black

        var appFont: AppFont {
            .init(fontName: AppFont.Name(rawValue: fontName)!, fontSize: CGFloat(fontSize), fontWeight: fontWeight)
        }
    }

    struct SubtitleFont: AutomaticSettings {
        var fontName: String = "Inter"
        // sourcery: range = 5.0...100.0
        var fontSize: Float = 18.0
        var fontWeight: AppFontWeight = .bold

        var appFont: AppFont {
            .init(fontName: AppFont.Name(rawValue: fontName)!, fontSize: CGFloat(fontSize), fontWeight: fontWeight)
        }
    }

    struct TextFont: AutomaticSettings {
        var fontName: String = "Inter"
        // sourcery: range = 5.0...100.0
        var fontSize: Float = 14.0
        var fontWeight: AppFontWeight = .regular

        var appFont: AppFont {
            .init(fontName: AppFont.Name(rawValue: fontName)!, fontSize: CGFloat(fontSize), fontWeight: fontWeight)
        }
    }

    var colors: Colors = .init()
    var titleFont: TitleFont = .init(fontName: "Inter", fontSize: 22, fontWeight: .black)
    var subtitleFont: SubtitleFont = .init(fontName: "Inter", fontSize: 18, fontWeight: .bold)
    var textFont: TextFont = .init(fontName: "Inter", fontSize: 14, fontWeight: .regular)
}

final class BetaSettingsExternalData: ObservableObject {}
