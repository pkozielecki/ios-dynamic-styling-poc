//
//  ColorExtensions.swift
//  Dynamic Styling POC
//

import SwiftUI

// Source: https://gist.github.com/peterfriese/bb2fc5df202f6a15cc807bd87ff15193
extension Color: Codable {
    public init(hex: String) {
        let rgba = hex.toRGBA()

        self.init(
            .sRGB,
            red: Double(rgba.red),
            green: Double(rgba.green),
            blue: Double(rgba.blue),
            opacity: Double(rgba.alpha)
        )
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)

        self.init(hex: hex)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(toHex)
    }

    var toHex: String? {
        toHex()
    }

    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor?.components, components.count >= 3 else {
            return nil
        }

        let rr = Float(components[0])
        let gg = Float(components[1])
        let bb = Float(components[2])
        var aa = Float(1.0)

        if components.count >= 4 {
            aa = Float(components[3])
        }

        if alpha {
            return String(
                format: "%02lX%02lX%02lX%02lX",
                lroundf(rr * 255),
                lroundf(gg * 255),
                lroundf(bb * 255),
                lroundf(aa * 255)
            )
        } else {
            return String(
                format: "%02lX%02lX%02lX",
                lroundf(rr * 255),
                lroundf(gg * 255),
                lroundf(bb * 255)
            )
        }
    }
}
