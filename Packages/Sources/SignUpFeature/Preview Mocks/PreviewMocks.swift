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
    var viewState: EmailEntryViewState = .idle
    func onViewAppeared() {}
    func onEmailRegistrationRequested(email password: String) async {}
    func onSignInRequested() {}
}

final class PreviewPasswordEntryViewModel: PasswordEntryViewModel {
    var viewState: PasswordEntryViewState = .idle
    func onPasswordRegistrationRequested(password: String) {}
    func passwordsMatch(password: String, passwordConfirmation: String) -> Bool { true }
}

#endif
