//
//  PasswordEntryViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

public enum PasswordEntryViewState: Equatable {
    case idle
    case loading
    case error(String)
}

// sourcery: AutoMockable
public protocol PasswordEntryViewModel: Observable {
    var viewState: PasswordEntryViewState { get }
    func onPasswordRegistrationRequested(password: String)
    func passwordsMatch(password: String, passwordConfirmation: String) -> Bool
}

@Observable public final class LivePasswordEntryViewModel: PasswordEntryViewModel {
    public private(set) var viewState: PasswordEntryViewState = .idle
    private let router: NavigationRouter
    private let email: String
    private let userRegistrationService: UserRegistrationService

    public init(
        email: String,
        router: NavigationRouter = resolve(),
        userRegistrationService: UserRegistrationService = LiveUserRegistrationService()
    ) {
        self.email = email
        self.router = router
        self.userRegistrationService = userRegistrationService
    }

    public func onPasswordRegistrationRequested(password: String) {
        viewState = .loading
        Task { @MainActor in
            do {
                let success = try await userRegistrationService.register(email: email, password: password)
                if success {
                    viewState = .idle
                    // TODO: Add Biometric setup view.
                    router.show(route: MainAppRoute.lobby, withData: email, introspective: true)
                } else {
                    viewState = .error("Email is not available.")
                }
            } catch {
                let message = (error as? EmailAvailabilityCheckError)?.message ?? "Unknown error"
                viewState = .error("Failed: \(message)")
            }
        }
    }

    public func passwordsMatch(password: String, passwordConfirmation: String) -> Bool {
        !password.isEmpty && password == passwordConfirmation
    }
}

private extension LivePasswordEntryViewModel {}
