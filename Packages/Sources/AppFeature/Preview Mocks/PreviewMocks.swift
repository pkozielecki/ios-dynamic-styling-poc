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
    var appStyleProvider: AppStyleProvider = LiveAppStyleProvider(initialDesignSystem: .preview)
    func onViewAppeared() {}
    func didRequestSignUp() {}
    func didRequestSignIn() {}
}

#endif
