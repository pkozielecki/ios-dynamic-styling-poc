//
//  EmailPasswordLoginModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

public enum EmailPasswordLoginViewState: Equatable {
    case loading
    case idle
    case error(String)
}

// sourcery: AutoMockable
public protocol EmailPasswordLoginViewModel: Observable {
    var viewState: EmailPasswordLoginViewState { get }
    func onViewAppeared()
    func onLoginRequested(email: String, password: String)
    func onSignUpRequested()
}

@Observable public final class LiveEmailPasswordLoginViewModel: EmailPasswordLoginViewModel {
    public private(set) var viewState: EmailPasswordLoginViewState = .idle
    private let router: NavigationRouter

    public init(router: NavigationRouter) {
        self.router = router
    }

    public func onViewAppeared() {
        // Discussion: Add analytics, etc.
    }

    public func onLoginRequested(email: String, password: String) {
        viewState = .loading

        // TODO: Add fake login attempt + random error generation
    }

    public func onSignUpRequested() {
        router.show(route: MainAppRoute.signUp, withData: nil, introspective: true)
    }
}

private extension LiveEmailPasswordLoginViewModel {}
