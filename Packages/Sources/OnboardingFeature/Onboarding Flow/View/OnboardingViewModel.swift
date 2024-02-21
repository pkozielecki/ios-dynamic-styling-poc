//
//  OnboardingViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

public protocol OnboardingViewModel: Observable {
    func onViewAppeared()
    func onFinishOnboardingPressed()
}

@Observable
public final class LiveOnboardingViewModel: OnboardingViewModel {
    private let router: NavigationRouter
    private let storage: LocalStorage

    public init(
        router: NavigationRouter,
        storage: LocalStorage
    ) {
        self.router = router
        self.storage = storage
    }

    public func onViewAppeared() {}

    public func onFinishOnboardingPressed() {
        markOnboardingAsFinished()
        router.show(route: OnboardingRoute.welcome, withData: true, introspective: false)
    }
}

private extension LiveOnboardingViewModel {
    func markOnboardingAsFinished() -> Void? {
        try? storage.setValue(true, forKey: StorageKeys.completedOnboarding.rawValue)
    }
}
