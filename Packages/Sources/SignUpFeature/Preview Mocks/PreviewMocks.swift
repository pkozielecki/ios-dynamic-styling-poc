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
    func onSignInRequested() {}
}

final class PreviewPasswordEntryViewModel: PasswordEntryViewModel {
    func onViewAppeared() {}
    func onPasswordRegistrationRequested(password: String) {}
}

#endif
