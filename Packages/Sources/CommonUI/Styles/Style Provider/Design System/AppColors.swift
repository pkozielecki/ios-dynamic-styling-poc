//
//  AppColors.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct AppColors: Equatable {
    public let error500: Color
    public let informative500: Color
    public let neutral500: Color
    public let primary100: Color
    public let primary500: Color
    public let primary900: Color
    public let secondary100: Color
    public let secondary500: Color
    public let secondary900: Color
    public let success500: Color
    public let tertiary100: Color
    public let text500: Color
    public let warning500: Color
    public let clear: Color

    public init(
        error500: Color,
        informative500: Color,
        neutral500: Color,
        primary100: Color,
        primary500: Color,
        primary900: Color,
        secondary100: Color,
        secondary500: Color,
        secondary900: Color,
        success500: Color,
        tertiary100: Color,
        text500: Color,
        warning500: Color,
        clear: Color
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
        self.clear = .clear
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

public struct AppColorsUpdate: Equatable {
    public let error500: Color?
    public let informative500: Color?
    public let neutral500: Color?
    public let primary100: Color?
    public let primary500: Color?
    public let primary900: Color?
    public let secondary100: Color?
    public let secondary500: Color?
    public let secondary900: Color?
    public let success500: Color?
    public let tertiary100: Color?
    public let text500: Color?
    public let warning500: Color?
    public let clear: Color?

    // TODO: Initialize from json.
}
