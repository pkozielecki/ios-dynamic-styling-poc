//
//  PreviewMocks.swift
//  Dynamic Styling POC
//

import Combine
import Common
import CommonUI
import Foundation

#if DEBUG

final class PreviewEmailPasswordLoginViewModel: EmailPasswordLoginViewModel {
    var viewState: EmailPasswordLoginViewState = .loading
    func onViewAppeared() {}
    func onLoginRequested(email: String, password: String) {}
    func onSignUpRequested() {}
}

#endif
