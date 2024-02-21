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
    func onViewAppeared() {}
    func didRequestSignUp() {}
    func didRequestSignIn() {}
}

final class PreviewOnboardingViewModel: OnboardingViewModel {
    func onViewAppeared() {}
    func onFinishOnboardingPressed() {}
}

#endif
