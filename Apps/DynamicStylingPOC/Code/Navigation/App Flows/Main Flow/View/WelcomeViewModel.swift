//
//  WelcomeViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Observation
import SwiftUI

protocol WelcomeViewModel: Observable {
    func onViewAppeared()
    func didRequestSignUp()
    func didRequestSignIn()
}

final class LiveWelcomeViewModel: WelcomeViewModel {
    private let router: NavigationRouter

    init(router: NavigationRouter) {
        self.router = router
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
