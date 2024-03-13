//
//  BiometricAuthenticationViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

enum BiometricAuthenticationViewState: Equatable {
    case authenticating
    case success
    case error(String)
}

// sourcery: AutoMockable
protocol BiometricAuthenticationViewModel: Observable {
    var viewState: BiometricAuthenticationViewState { get }
    func onViewAppeared() async
    func didRequestTryAgain() async
    func didRequestSignIn()
}

@Observable
final class LiveBiometricAuthenticationViewModel: BiometricAuthenticationViewModel {
    private(set) var viewState: BiometricAuthenticationViewState = .authenticating

    private let router: NavigationRouter
    private let biometricStorage: BiometricStorage
    private let inMemoryStorage: InMemoryStorage
    private let biometricAccessProvider: BiometricAccessProvider

    init(
        router: NavigationRouter,
        biometricStorage: BiometricStorage,
        inMemoryStorage: InMemoryStorage,
        biometricAccessProvider: BiometricAccessProvider
    ) {
        self.router = router
        self.biometricStorage = biometricStorage
        self.inMemoryStorage = inMemoryStorage
        self.biometricAccessProvider = biometricAccessProvider
    }

    func onViewAppeared() async {
        await triggerBiometricAuthentication()
    }

    func didRequestTryAgain() async {
        await triggerBiometricAuthentication()
    }

    func didRequestSignIn() {
        router.show(route: MainAppRoute.signIn, withData: nil, introspective: true)
    }
}

private extension LiveBiometricAuthenticationViewModel {
    @MainActor func triggerBiometricAuthentication() async {
        let biometrics = biometricAccessProvider.getSupportedBiometricsType()
        if !biometrics.isBiometryEnabled {
            viewState = .error("Biometrics not enabled.")
            return
        }

        do {
            if await biometricAccessProvider.requestPermissionToAccessBiometrics(for: biometrics) {
                let token: String? = try await biometricStorage.retrieve(itemAt: .refreshToken)
                handle(refreshToken: token)
            } else {
                viewState = .error("Biometrics denied.")
                return
            }
        } catch {
            viewState = .error("Try again.")
        }
    }

    @MainActor func handle(refreshToken token: String?) {
        if let token {
            inMemoryStorage.setValue(token, forKey: .refreshToken)
            viewState = .success
            router.show(route: MainAppRoute.lobby, withData: nil, introspective: true)
        } else {
            viewState = .error("Invlid token.")
        }
    }
}
