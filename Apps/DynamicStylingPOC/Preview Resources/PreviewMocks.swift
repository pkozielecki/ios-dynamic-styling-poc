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

#endif
