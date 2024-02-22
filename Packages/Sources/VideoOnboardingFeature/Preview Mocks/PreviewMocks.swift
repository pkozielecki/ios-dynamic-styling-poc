//
//  PreviewMocks.swift
//  Dynamic Styling POC
//

import Combine
import Common
import CommonUI
import Foundation

#if DEBUG

final class PreviewOnboardingViewModel: VideoOnboardingViewModel {
    func onViewAppeared() {}
    func onFinishOnboardingPressed() {}
}

#endif
