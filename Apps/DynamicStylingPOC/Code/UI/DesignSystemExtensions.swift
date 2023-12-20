//
//  DesignSystemExtensions.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

extension DesignSystem {
    static var `default`: DesignSystem {
        DesignSystem(
            colors: .default
        )
    }
}

extension Colors {
    static var `default`: Colors {
        Colors(
            error500: Color("Error500"),
            informative500: Color("Informative500"),
            neutral500: Color("Neutral500"),
            primary100: Color("Primary100"),
            primary500: Color("Primary500"),
            primary900: Color("Primary900"),
            secondary100: Color("Secondary100"),
            secondary500: Color("econdary500"),
            secondary900: Color("Secondary900"),
            success500: Color("Success500"),
            tertiary100: Color("Tertiary100"),
            text500: Color("Text500"),
            warning500: Color("Warning500")
        )
    }
}
