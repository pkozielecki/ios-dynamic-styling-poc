//
//  PreviewMocks.swift
//  Dynamic Styling POC
//

import Foundation

#if DEBUG

public enum PreviewFactory {
    public static func makeStyleProvider() -> AppStyleProvider {
        LiveAppStyleProvider(
            appStyleSynchroniser: PreviewAppStyleSynchroniser(),
            initialAppStyle: .init(initialDesignSystem: .preview, intialComponents: .preview)
        )
    }
}

public final class PreviewAppStyleSynchroniser: AppStyleSynchroniser {
    public func synchroniseStyles(currentStyle: AppStyle) async -> AppStyle {
        AppStyle(initialDesignSystem: .init(colors: .preview, fonts: .default), intialComponents: .preview)
    }
}

#endif
