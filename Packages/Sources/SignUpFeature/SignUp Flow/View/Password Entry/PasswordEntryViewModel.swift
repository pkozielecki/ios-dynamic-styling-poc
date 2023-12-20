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
    var viewState: PasswordEntryViewState { get }
    func onViewAppeared()
    func onPasswordRegistrationRequested(password: String)
}

@Observable
final class LivePasswordEntryViewModel: PasswordEntryViewModel {
    private(set) var viewState: PasswordEntryViewState = .loading

    private let router: NavigationRouter

    init(router: NavigationRouter) {
        self.router = router
    }

    func onViewAppeared() {}

    func onPasswordRegistrationRequested(password: String) {}
}

private extension LivePasswordEntryViewModel {}
