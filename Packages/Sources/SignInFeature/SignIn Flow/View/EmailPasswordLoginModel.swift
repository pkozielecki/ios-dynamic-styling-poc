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
    private let storage: InMemoryStorage
    private let authenticationService: EmailPasswordAuthenticationService

    public init(
        router: NavigationRouter,
        storage: InMemoryStorage,
        authenticationService: EmailPasswordAuthenticationService = LiveEmailPasswordAuthenticationService()
    ) {
        self.router = router
        self.storage = storage
        self.authenticationService = authenticationService
    }

    public func onViewAppeared() {
        // Discussion: Add analytics, etc.
    }

    public func onLoginRequested(email: String, password: String) {
        viewState = .loading
        Task { @MainActor in
            do {
                let token = try await authenticationService.authenticate(email: email, password: password)
                storage.setValue(token, forKey: .refreshToken)
                viewState = .idle
                router.show(route: MainAppRoute.biometricSetup, withData: nil, introspective: true)
            } catch {
                let message = (error as? UserAuthenticationError)?.message ?? "Unknown error"
                viewState = .error("Failed: \(message)")
            }
        }
    }

    public func onSignUpRequested() {
        router.show(route: MainAppRoute.signUp, withData: nil, introspective: true)
    }
}
