//
//  PasswordEntryViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

enum PasswordEntryViewState: Equatable {
    case loading
}

protocol PasswordEntryViewModel: Observable, AppViewStyleProvider {
    var appStyleProvider: AppStyleProvider { get }
    var viewState: PasswordEntryViewState { get }
    func onViewAppeared()
    func onPasswordRegistrationRequested(password: String)
}

@Observable final class LivePasswordEntryViewModel: PasswordEntryViewModel {
    let appStyleProvider: AppStyleProvider
    private(set) var viewState: PasswordEntryViewState = .loading

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

    func onPasswordRegistrationRequested(password: String) {}
}

private extension LivePasswordEntryViewModel {}
