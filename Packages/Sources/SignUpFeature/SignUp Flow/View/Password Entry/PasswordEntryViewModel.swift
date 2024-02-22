//
//  PasswordEntryViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

// sourcery: AutoMockable
public protocol PasswordEntryViewModel: Observable {
    func onViewAppeared()
    func onPasswordRegistrationRequested(password: String)
}

@Observable public final class LivePasswordEntryViewModel: PasswordEntryViewModel {
    private let router: NavigationRouter

    public init(
        router: NavigationRouter = resolve()
    ) {
        self.router = router
    }

    public func onViewAppeared() {}

    public func onPasswordRegistrationRequested(password: String) {}
}

private extension LivePasswordEntryViewModel {}
