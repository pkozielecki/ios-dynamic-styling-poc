//
//  WelcomeViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation
import SwiftUI

// sourcery: AutoMockable
public protocol WelcomeViewModel: Observable {
    func onViewAppeared()
    func didRequestSignUp()
    func didRequestSignIn()
}

@Observable
public final class LiveWelcomeViewModel: WelcomeViewModel {
    private let router: NavigationRouter

    public init(
        router: NavigationRouter = resolve()
    ) {
        self.router = router
    }

    public func onViewAppeared() {}

    public func didRequestSignUp() {
        router.show(route: MainAppRoute.signUp, withData: nil, introspective: true)
    }

    public func didRequestSignIn() {
        router.show(route: MainAppRoute.signIn, withData: nil, introspective: true)
    }
}
