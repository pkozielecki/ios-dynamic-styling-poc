//
//  PreviewMocks.swift
//  Dynamic Styling POC
//

import Combine
import Common
import CommonUI
import Foundation

#if DEBUG

final class PreviewWelcomeViewModel: WelcomeViewModel {
    var appStyleProvider: AppStyleProvider = LiveAppStyleProvider(designSystem: .default)
    func onViewAppeared() {}
    func didRequestSignUp() {}
    func didRequestSignIn() {}
}

final class PreviewEmailEntryViewModel: EmailEntryViewModel {
    var viewState: EmailEntryViewState = .loading
    func onViewAppeared() {}
    func onEmailRegistrationRequested(email password: String) {}
}

final class PreviewEmailPasswordLoginViewModel: EmailPasswordLoginViewModel {
    var viewState: EmailPasswordLoginViewState = .loading
    func onViewAppeared() {}
}

final class PreviewPasswordEntryViewModel: PasswordEntryViewModel {
    var viewState: PasswordEntryViewState = .loading
    func onViewAppeared() {}
    func onPasswordRegistrationRequested(password: String) {}
}

#endif
