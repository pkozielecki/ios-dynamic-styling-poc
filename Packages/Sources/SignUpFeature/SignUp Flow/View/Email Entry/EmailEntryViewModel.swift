//
//  EmailEntryViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

public enum EmailEntryViewState: Equatable {
    case loading
}

// sourcery: AutoMockable
public protocol EmailEntryViewModel: Observable {
    var viewState: EmailEntryViewState { get }
    func onViewAppeared()
    func onEmailRegistrationRequested(email: String)
    func onSignInRequested()
}

@Observable public final class LiveEmailEntryViewModel: EmailEntryViewModel {
    public private(set) var viewState: EmailEntryViewState = .loading
    private let router: NavigationRouter

    public init(
        router: NavigationRouter = resolve()
    ) {
        self.router = router
    }

    public func onViewAppeared() {}

    public func onEmailRegistrationRequested(email: String) {
        router.show(route: SignUpRoute.passwordEntry, withData: email, introspective: false)
    }

    public func onSignInRequested() {
        router.show(route: MainAppRoute.signIn, withData: nil, introspective: true)
    }
}

private extension LiveEmailEntryViewModel {}
