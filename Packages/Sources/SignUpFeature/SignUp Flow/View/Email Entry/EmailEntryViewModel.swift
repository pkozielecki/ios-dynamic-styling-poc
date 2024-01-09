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
    var appStyleProvider: AppStyleProvider { get }
    func onViewAppeared()
    func onEmailRegistrationRequested(email: String)
}

@Observable
final class LiveEmailEntryViewModel: EmailEntryViewModel {
    private(set) var viewState: EmailEntryViewState = .loading

    let appStyleProvider: AppStyleProvider
    private let router: NavigationRouter

    init(
        router: NavigationRouter = resolve(),
        appStyleProvider: AppStyleProvider = resolve()
    ) {
        self.router = router
        self.appStyleProvider = appStyleProvider
        // TODO: Subscribe to the style update
    }

    func onViewAppeared() {}

    func onEmailRegistrationRequested(email: String) {
        print("🚀 Email registered: \(email)")
        router.show(route: SignUpRoute.passwordEntry, withData: email)
    }
}

private extension LiveEmailEntryViewModel {}
