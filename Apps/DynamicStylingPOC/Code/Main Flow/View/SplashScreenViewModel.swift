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

    init(
        router: NavigationRouter,
        userStatusProvider: UserStatusProvider
    ) {
        self.router = router
        self.userStatusProvider = userStatusProvider
    }

    func onViewAppeared() {
        Task { @MainActor in
            // Discussion: This is to simulate Remote Config / Styles update from server.
            try await Task.sleep(nanoseconds: 2000000000)
            router.show(route: routeToShow, withData: nil, introspective: false)
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
}