//
//  AppColor.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppColor: Codable, Equatable {
    let lightModeValue: String
    let darkModeValue: String
}

public extension AppColor {
    init(light: UIColor, dark: UIColor) {
        if let light = light.hex, let dark = dark.hex {
            self.init(lightModeValue: light, darkModeValue: dark)
            return
        } else {
            let clearColorHex = UIColor.clear.hex ?? "#00000000"
            self.init(lightModeValue: clearColorHex, darkModeValue: clearColorHex)
        }
    }

    init(named name: String) {
        let color = UIColor(named: name) ?? .clear
        self.init(light: color.light, dark: color.dark)
    }

    var uiColor: UIColor? {
        UIColor(
            dynamicProvider: { traits in
                switch traits.userInterfaceStyle {
                case .light, .unspecified:
                    return UIColor(lightModeColor)

                case .dark:
                    return UIColor(darkModeColor)

                @unknown default:
                    assertionFailure("Unknown userInterfaceStyle: \(traits.userInterfaceStyle)")
                    return UIColor(lightModeColor)
                }
            }
        )
    }

    var color: Color? {
        if let uiColor {
            return Color(uiColor)
        }
        return nil
    }
}

private extension AppColor {
    var lightModeColor: Color {
        Color(hex: lightModeValue)
    }

    var darkModeColor: Color {
        Color(hex: darkModeValue)
    }
}

public extension UIColor {
    var hex: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        let multiplier = CGFloat(255.999999)

        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        } else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }

    var dark: UIColor {
        resolvedColor(with: .init(userInterfaceStyle: .dark))
    }

    var light: UIColor {
        resolvedColor(with: .init(userInterfaceStyle: .light))
    }
}

// Based on: https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
public extension String {
    var uiColor: UIColor? {
        let rr, gg, bb, aa: CGFloat

        if hasPrefix("#") {
            let start = index(startIndex, offsetBy: 1)
            let hexColor = String(self[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    rr = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    gg = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    bb = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    aa = CGFloat(hexNumber & 0x000000ff) / 255

                    return UIColor(red: rr, green: gg, blue: bb, alpha: aa)
                }
            }
        }

        return nil
    }
}
