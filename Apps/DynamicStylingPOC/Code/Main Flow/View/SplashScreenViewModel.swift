//
//  SplashScreenViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

protocol SplashScreenViewModel: Observable {
    func onViewAppeared()
}

@Observable
final class LiveSplashScreenViewModel: SplashScreenViewModel {
    private let router: NavigationRouter
    private let userStatusProvider: UserStatusProvider
    private let storage: LocalStorage
    private let delayGenerator: DelayGenerator

    init(
        router: NavigationRouter,
        userStatusProvider: UserStatusProvider,
        storage: LocalStorage,
        delayGenerator: DelayGenerator = LiveDelayGenerator()
    ) {
        self.router = router
        self.userStatusProvider = userStatusProvider
        self.storage = storage
        self.delayGenerator = delayGenerator
    }

    func onViewAppeared() {
        Task { @MainActor in
            // Discussion: This is to simulate Remote Config / Styles update from server.
            await delayGenerator.generate(delay: 2)
            router.show(route: routeToShow, withData: nil, introspective: false)
            setFirstLaunchStatus()
        }
    }
}

private extension LiveSplashScreenViewModel {
    var routeToShow: any Route {
        let status = userStatusProvider.userStatus
        switch status {
        case .firstLaunch, .onboardingNotFinished:
            return MainAppRoute.onboarding
        case .authenticated:
            return MainAppRoute.lobby
        case .onboardingFinished:
            return MainAppRoute.signUp
        }
    }

    func setFirstLaunchStatus() {
        try? storage.setValue(false, forKey: StorageKeys.firstLaunch.rawValue)
    }
}
