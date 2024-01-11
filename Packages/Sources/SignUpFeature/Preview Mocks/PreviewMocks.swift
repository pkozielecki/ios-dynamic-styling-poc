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
    var appStyleProvider: AppStyleProvider = LiveAppStyleProvider(initialDesignSystem: .preview)
    var viewState: EmailEntryViewState = .loading
    func onViewAppeared() {}
    func onEmailRegistrationRequested(email password: String) {}
}

final class PreviewPasswordEntryViewModel: PasswordEntryViewModel {
    var appStyleProvider: AppStyleProvider = LiveAppStyleProvider(initialDesignSystem: .preview)
    var viewState: PasswordEntryViewState = .loading
    func onViewAppeared() {}
    func onPasswordRegistrationRequested(password: String) {}
}

#endif
