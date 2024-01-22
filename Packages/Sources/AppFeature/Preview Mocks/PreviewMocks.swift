//
//  PreviewMocks.swift
//  Dynamic Styling POC
//

import Combine
import Common
import CommonUI
import Foundation

#if DEBUG

final class PreviewAppStyleSynchroniser: AppStyleSynchroniser {
    func synchroniseStyles(currentStyle: CommonUI.AppStyle) async -> AppStyle {
        AppStyle(initialDesignSystem: .init(colors: .preview, fonts: .default))
    }
}

final class PreviewWelcomeViewModel: WelcomeViewModel {
    func onViewAppeared() {}
    func didRequestSignUp() {}
    func didRequestSignIn() {}
}

enum PreviewFactory {
    static func makeStyleProvider() -> AppStyleProvider {
        LiveAppStyleProvider(
            appStyleSynchroniser: PreviewAppStyleSynchroniser(),
            initialDesignSystem: .preview
        )
    }
}

#endif
