//
//  WelcomeViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation
import SwiftUI

protocol WelcomeViewModel: Observable {
    func onViewAppeared()
    func didRequestSignUp()
    func didRequestSignIn()
}

@Observable final class LiveWelcomeViewModel: WelcomeViewModel {
    private let router: NavigationRouter

    init(
        router: NavigationRouter = resolve()
    ) {
        self.router = router
    }

    func onViewAppeared() {}

    func didRequestSignUp() {
        router.show(route: MainAppRoute.signUp, withData: nil)
    }

    func didRequestSignIn() {
        router.show(route: MainAppRoute.signIn, withData: nil)
    }
}
