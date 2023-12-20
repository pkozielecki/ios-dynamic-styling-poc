//
//  WelcomeViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Observation
import SwiftUI

protocol WelcomeViewModel: Observable {
    var appStyleProvider: AppStyleProvider { get }
    func onViewAppeared()
    func didRequestSignUp()
    func didRequestSignIn()
}

final class LiveWelcomeViewModel: WelcomeViewModel {
    private let router: NavigationRouter
    let appStyleProvider: AppStyleProvider

    init(
        router: NavigationRouter = resolve(),
        appStyleProvider: AppStyleProvider = resolve()
    ) {
        self.router = router
        self.appStyleProvider = appStyleProvider
        // TODO: Subscribe to the style update
    }

    // TODO: Emitt view state

    func onViewAppeared() {}

    func didRequestSignUp() {
        router.show(route: MainAppRoute.signUp, withData: nil)
    }

    func didRequestSignIn() {
        router.show(route: MainAppRoute.signIn, withData: nil)
    }
}
