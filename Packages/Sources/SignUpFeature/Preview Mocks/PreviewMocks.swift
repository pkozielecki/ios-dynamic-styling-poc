//
//  PreviewMocks.swift
//  Dynamic Styling POC
//

import Combine
import Common
import CommonUI
import Foundation

#if DEBUG

final class PreviewEmailEntryViewModel: EmailEntryViewModel {
    var viewState: EmailEntryViewState = .loading
    func onViewAppeared() {}
    func onEmailRegistrationRequested(email password: String) {}
}

final class PreviewPasswordEntryViewModel: PasswordEntryViewModel {
    var viewState: PasswordEntryViewState = .loading
    func onViewAppeared() {}
    func onPasswordRegistrationRequested(password: String) {}
}

final class PreviewAppStyleSynchroniser: AppStyleSynchroniser {
    func synchroniseStyles(currentStyle: CommonUI.AppStyle) async -> AppStyle {
        AppStyle(initialDesignSystem: .init(colors: .preview, fonts: .default))
    }
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
