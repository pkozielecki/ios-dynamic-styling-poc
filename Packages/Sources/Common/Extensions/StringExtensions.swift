//
//  StringExtensions.swift
//  Dynamic Styling POC
//

import Foundation

public extension String {
    func toRGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var hexSanitized = trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        let length = hexSanitized.count

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        if length == 6 {
            red = CGFloat((rgb & 0xff0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00ff00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x0000ff) / 255.0
        } else if length == 8 {
            red = CGFloat((rgb & 0xff000000) >> 24) / 255.0
            green = CGFloat((rgb & 0x00ff0000) >> 16) / 255.0
            blue = CGFloat((rgb & 0x0000ff00) >> 8) / 255.0
            alpha = CGFloat(rgb & 0x000000ff) / 255.0
        }

        return (red, green, blue, alpha)
    }
}
