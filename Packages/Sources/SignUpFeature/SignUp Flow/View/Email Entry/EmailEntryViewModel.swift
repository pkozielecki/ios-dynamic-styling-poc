//
//  EmailEntryViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

public enum EmailEntryViewState: Equatable {
    case idle
    case loading
    case error(String)
}

// sourcery: AutoMockable
public protocol EmailEntryViewModel: Observable {
    var viewState: EmailEntryViewState { get }
    func onViewAppeared()
    func onEmailRegistrationRequested(email: String) async
    func onSignInRequested()
}

@Observable public final class LiveEmailEntryViewModel: EmailEntryViewModel {
    public private(set) var viewState: EmailEntryViewState = .idle
    private let router: NavigationRouter
    private let availabilityChecker: EmailAvailabilityChecker

    public init(
        router: NavigationRouter = resolve(),
        availabilityChecker: EmailAvailabilityChecker = LiveEmailRegistrationService()
    ) {
        self.router = router
        self.availabilityChecker = availabilityChecker
    }

    public func onViewAppeared() {}

    @MainActor public func onEmailRegistrationRequested(email: String) async {
        viewState = .loading
        do {
            let success = try await availabilityChecker.check(email: email)
            if success {
                viewState = .idle
                router.show(route: SignUpRoute.passwordEntry, withData: email, introspective: false)
            } else {
                viewState = .error("Email is not available.")
            }
        } catch {
            let message = (error as? EmailAvailabilityCheckError)?.message ?? "Unknown error"
            viewState = .error("Failed: \(message)")
        }
    }

    public func onSignInRequested() {
        router.show(route: MainAppRoute.signIn, withData: nil, introspective: true)
    }
}

private extension LiveEmailEntryViewModel {}
