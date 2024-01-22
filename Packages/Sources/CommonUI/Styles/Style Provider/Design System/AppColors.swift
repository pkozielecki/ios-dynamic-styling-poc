//
//  AppColors.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppColors: Equatable, Codable {
    public let error500: AppColor
    public let informative500: AppColor
    public let neutral500: AppColor
    public let primary100: AppColor
    public let primary500: AppColor
    public let primary900: AppColor
    public let secondary100: AppColor
    public let secondary500: AppColor
    public let secondary900: AppColor
    public let success500: AppColor
    public let tertiary100: AppColor
    public let text500: AppColor
    public let warning500: AppColor
    public let clear: AppColor

    public init(
        error500: UIColor,
        informative500: UIColor,
        neutral500: UIColor,
        primary100: UIColor,
        primary500: UIColor,
        primary900: UIColor,
        secondary100: UIColor,
        secondary500: UIColor,
        secondary900: UIColor,
        success500: UIColor,
        tertiary100: UIColor,
        text500: UIColor,
        warning500: UIColor,
        clear: UIColor
    ) {
        self.error500 = AppColor(light: error500.light, dark: error500.dark)
        self.informative500 = AppColor(light: informative500.light, dark: informative500.dark)
        self.neutral500 = AppColor(light: neutral500.light, dark: neutral500.dark)
        self.primary100 = AppColor(light: primary100.light, dark: primary100.dark)
        self.primary500 = AppColor(light: primary500.light, dark: primary500.dark)
        self.primary900 = AppColor(light: primary900.light, dark: primary900.dark)
        self.secondary100 = AppColor(light: secondary100.light, dark: secondary100.dark)
        self.secondary500 = AppColor(light: secondary500.light, dark: secondary500.dark)
        self.secondary900 = AppColor(light: secondary900.light, dark: secondary900.dark)
        self.success500 = AppColor(light: success500.light, dark: success500.dark)
        self.tertiary100 = AppColor(light: tertiary100.light, dark: tertiary100.dark)
        self.text500 = AppColor(light: text500.light, dark: text500.dark)
        self.warning500 = AppColor(light: warning500.light, dark: warning500.dark)
        self.clear = AppColor(light: clear.light, dark: clear.dark)
    }

    public init(
        error500: AppColor,
        informative500: AppColor,
        neutral500: AppColor,
        primary100: AppColor,
        primary500: AppColor,
        primary900: AppColor,
        secondary100: AppColor,
        secondary500: AppColor,
        secondary900: AppColor,
        success500: AppColor,
        tertiary100: AppColor,
        text500: AppColor,
        warning500: AppColor,
        clear: AppColor
    ) {
        self.error500 = error500
        self.informative500 = informative500
        self.neutral500 = neutral500
        self.primary100 = primary100
        self.primary500 = primary500
        self.primary900 = primary900
        self.secondary100 = secondary100
        self.secondary500 = secondary500
        self.secondary900 = secondary900
        self.success500 = success500
        self.tertiary100 = tertiary100
        self.text500 = text500
        self.warning500 = warning500
        self.clear = clear
    }

    public func merging(with colorUpdate: AppColorsUpdate?) -> AppColors {
        AppColors(
            error500: colorUpdate?.error500 ?? error500,
            informative500: colorUpdate?.informative500 ?? informative500,
            neutral500: colorUpdate?.neutral500 ?? neutral500,
            primary100: colorUpdate?.primary100 ?? primary100,
            primary500: colorUpdate?.primary500 ?? primary500,
            primary900: colorUpdate?.primary900 ?? primary900,
            secondary100: colorUpdate?.secondary100 ?? secondary100,
            secondary500: colorUpdate?.secondary500 ?? secondary500,
            secondary900: colorUpdate?.secondary900 ?? secondary900,
            success500: colorUpdate?.success500 ?? success500,
            tertiary100: colorUpdate?.tertiary100 ?? tertiary100,
            text500: colorUpdate?.text500 ?? text500,
            warning500: colorUpdate?.warning500 ?? warning500,
            clear: colorUpdate?.clear ?? clear
        )
    }
}

public struct AppColorsUpdate: Equatable, Codable {
    public let error500: AppColor?
    public let informative500: AppColor?
    public let neutral500: AppColor?
    public let primary100: AppColor?
    public let primary500: AppColor?
    public let primary900: AppColor?
    public let secondary100: AppColor?
    public let secondary500: AppColor?
    public let secondary900: AppColor?
    public let success500: AppColor?
    public let tertiary100: AppColor?
    public let text500: AppColor?
    public let warning500: AppColor?
    public let clear: AppColor?
}
