//
//  PreviewDesignSystem.swift
//  Dynamic Styling POC
//

import Foundation
import SwiftUI

public extension AppComponentsStyles {
    static var preview: AppComponentsStyles {
        AppComponentsStyles(
            // TODO: Add styles for previews!!!
            text: [:]
        )
    }
}

public extension AppDesignSystem {
    static var preview: AppDesignSystem {
        AppDesignSystem(
            colors: .preview,
            fonts: .default
        )
    }
}

public extension AppColors {
    static var preview: AppColors {
        AppColors(
            error500: UIColor(Color("Error500", bundle: Bundle.module)),
            informative500: UIColor(Color("Informative500", bundle: Bundle.module)),
            neutral500: UIColor(Color("Neutral500", bundle: Bundle.module)),
            primary100: UIColor(Color("Primary100", bundle: Bundle.module)),
            primary500: UIColor(Color("Primary500", bundle: Bundle.module)),
            primary900: UIColor(Color("Primary900", bundle: Bundle.module)),
            secondary100: UIColor(Color("Secondary100", bundle: Bundle.module)),
            secondary500: UIColor(Color("econdary500", bundle: Bundle.module)),
            secondary900: UIColor(Color("Secondary900", bundle: Bundle.module)),
            success500: UIColor(Color("Success500", bundle: Bundle.module)),
            tertiary100: UIColor(Color("Tertiary100", bundle: Bundle.module)),
            text500: UIColor(Color("Text500", bundle: Bundle.module)),
            warning500: UIColor(Color("Warning500", bundle: Bundle.module)),
            clear: .clear
        )
    }
}
