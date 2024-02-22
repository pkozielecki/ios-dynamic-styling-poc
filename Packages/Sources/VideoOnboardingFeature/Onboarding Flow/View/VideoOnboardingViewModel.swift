//
//  VideoOnboardingViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

// sourcery: AutoMockable
public protocol VideoOnboardingViewModel: Observable {
    func onViewAppeared()
    func onFinishOnboardingPressed()
}

@Observable
public final class LiveVideoOnboardingViewModel: VideoOnboardingViewModel {
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
        router.show(route: MainAppRoute.signIn, withData: nil, introspective: true)
    }
}

private extension LiveVideoOnboardingViewModel {
    func markOnboardingAsFinished() -> Void? {
        try? storage.setValue(true, forKey: StorageKeys.completedOnboarding.rawValue)
    }
}
