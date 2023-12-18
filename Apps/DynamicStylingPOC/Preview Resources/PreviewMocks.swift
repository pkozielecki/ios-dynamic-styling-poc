//
//  PreviewMocks.swift
//  Dynamic Styling POC
//

import Common
import Foundation

#if DEBUG

final class PreviewWelcomeViewModel: WelcomeViewModel {
    func onViewAppeared() {}

    func didRequestSignUp() {}

    func didRequestSignIn() {}
}

final class PreviewEmailEntryViewModel: EmailEntryViewModel {
    var viewState: EmailEntryViewState = .loading

    func onViewAppeared() {}
}

final class PreviewEmailPasswordLoginViewModel: EmailPasswordLoginViewModel {
    var viewState: EmailPasswordLoginViewState = .loading

    func onViewAppeared() {}
}

#endif
