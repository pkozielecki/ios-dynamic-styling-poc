//
//  Colors.swift
//  Dynamic Styling POC
//

import Foundation
import SwiftUI

public struct Colors: Equatable {
    // TODO: Add more colors
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
        warning500: Color
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
    }
}
