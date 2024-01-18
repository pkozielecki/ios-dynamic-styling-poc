//
//  AppStyleProvider.swift
//  Dynamic Styling POC
//

import Combine
import Common
import Foundation
import SwiftUI
import UIKit

public protocol AppStyleProvider: Observable {
    var appStyle: AppStyle { get }
    func refreshStyles() async
}

@Observable public final class LiveAppStyleProvider {
    private var initialDesignSystem: AppDesignSystem
    public private(set) var appStyle: AppStyle

    public init(initialDesignSystem: AppDesignSystem) {
        // Discussion: This is initial (built-in) app style.
        // ... It will be merged with the one obrained from the BE.
        self.initialDesignSystem = initialDesignSystem
        appStyle = AppStyle(initialDesignSystem: initialDesignSystem)

        // TODO: Trigger getting style update from the CMS.
    }
}

extension LiveAppStyleProvider: AppStyleProvider {
    public func refreshStyles() async {
        print("🟠 Styles refresh requested")

        // TODO: Take values from the web.
        let designSystemUpdate = DesignSystemUpdate(
            colors: AppColorsUpdate.random,
            fonts: AppFontsUpdate.random
        )

        appStyle.update(with: nil, and: designSystemUpdate)

        print("🟢 Styles refresh finished!")
    }
}

// TODO: Remove when getting styles from the web.
extension AppColorsUpdate {
    static var random: AppColorsUpdate {
        AppColorsUpdate(
            error500: .random(),
            informative500: .random(),
            neutral500: .random(),
            primary100: .random(),
            primary500: .random(),
            primary900: .random(),
            secondary100: .random(),
            secondary500: .random(),
            secondary900: .random(),
            success500: .random(),
            tertiary100: .random(),
            text500: .random(),
            warning500: .random(),
            clear: nil
        )
    }
}

// TODO: Remove when getting styles from the web.
extension AppFontsUpdate {
    static var random: AppFontsUpdate {
        AppFontsUpdate(
            title: .init(fontName: AppFonts.Names.inter.rawValue, fontSize: CGFloat.random(in: 20...30), fontWeight: Bool.random() ? .regular : .heavy),
            subtitle: .init(fontName: AppFonts.Names.inter.rawValue, fontSize: CGFloat.random(in: 14...20), fontWeight: Bool.random() ? .thin : .bold),
            text: .init(fontName: AppFonts.Names.inter.rawValue, fontSize: CGFloat.random(in: 10...14), fontWeight: Bool.random() ? .regular : .medium)
        )
    }
}

// TODO: Remove when getting styles from the web.
extension AppColor {
    static func random(randomOpacity: Bool = false) -> AppColor {
        let colorLight = Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
        let colorDark = Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
        return AppColor(light: UIColor(colorLight), dark: UIColor(colorDark))
    }
}
