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

protocol PasswordEntryViewModel: Observable {
    func onViewAppeared()
    func onPasswordRegistrationRequested(password: String)
}

@Observable final class LivePasswordEntryViewModel: PasswordEntryViewModel {
    private(set) var viewState: PasswordEntryViewState = .loading

    private let router: NavigationRouter

    init(
        router: NavigationRouter = resolve()
    ) {
        self.router = router
    }

    func onViewAppeared() {}

    func onPasswordRegistrationRequested(password: String) {}
}

private extension LivePasswordEntryViewModel {}
