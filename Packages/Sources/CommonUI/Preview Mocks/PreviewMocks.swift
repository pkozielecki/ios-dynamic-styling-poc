//
//  PreviewMocks.swift
//  Dynamic Styling POC
//

import Foundation

#if DEBUG

public enum PreviewFactory {
    public static func makeStyleProvider() -> AppStyleProvider {
        let designSystem = AppDesignSystem(colors: .preview, fonts: .default)
        let appStyle = AppStyle(initialDesignSystem: designSystem, intialComponents: .default)
        return LiveAppStyleProvider(
            appStyleSynchroniser: PreviewAppStyleSynchroniser(styleToReturn: appStyle),
            initialAppStyle: appStyle
        )
    }
}

public final class PreviewAppStyleSynchroniser: AppStyleSynchroniser {
    private let styleToReturn: AppStyle
    init(styleToReturn: AppStyle) {
        self.styleToReturn = styleToReturn
    }

    public func synchroniseStyles(currentStyle: AppStyle) async -> AppStyle {
        styleToReturn
    }
}

#endif
