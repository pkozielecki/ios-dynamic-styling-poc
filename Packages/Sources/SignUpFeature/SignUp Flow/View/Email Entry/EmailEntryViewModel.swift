//
//  EmailEntryViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

enum EmailEntryViewState: Equatable {
    case loading
}

protocol EmailEntryViewModel: Observable {
    var viewState: EmailEntryViewState { get }
    func onViewAppeared()
    func onEmailRegistrationRequested(email: String)
}

@Observable final class LiveEmailEntryViewModel: EmailEntryViewModel {
    private(set) var viewState: EmailEntryViewState = .loading
    private let router: NavigationRouter

    init(
        router: NavigationRouter = resolve()
    ) {
        self.router = router
    }

    func onViewAppeared() {}

    func onEmailRegistrationRequested(email: String) {
        router.show(route: SignUpRoute.passwordEntry, withData: email, introspective: false)
    }
}

private extension LiveEmailEntryViewModel {}
