//
//  PreviewDesignSystem.swift
//  Dynamic Styling POC
//

import Foundation
import SwiftUI

public extension DesignSystem {
    static var preview: DesignSystem {
        DesignSystem(
            colors: .preview,
            fonts: .default,
            fontWights: .default
        )
    }
}

public extension AppColors {
    static var preview: AppColors {
        AppColors(
            error500: Color("Error500", bundle: Bundle.module),
            informative500: Color("Informative500", bundle: Bundle.module),
            neutral500: Color("Neutral500", bundle: Bundle.module),
            primary100: Color("Primary100", bundle: Bundle.module),
            primary500: Color("Primary500", bundle: Bundle.module),
            primary900: Color("Primary900", bundle: Bundle.module),
            secondary100: Color("Secondary100", bundle: Bundle.module),
            secondary500: Color("econdary500", bundle: Bundle.module),
            secondary900: Color("Secondary900", bundle: Bundle.module),
            success500: Color("Success500", bundle: Bundle.module),
            tertiary100: Color("Tertiary100", bundle: Bundle.module),
            text500: Color("Text500", bundle: Bundle.module),
            warning500: Color("Warning500", bundle: Bundle.module),
            clear: .clear
        )
    }
}
