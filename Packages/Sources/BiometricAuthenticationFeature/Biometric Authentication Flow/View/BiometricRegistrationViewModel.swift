//
//  BiometricRegistrationViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

enum BiometricRegistrationViewState: Equatable {
    case registering
    case success
    case error(String)
}

protocol BiometricRegistrationViewModel: Observable {
    var viewState: BiometricRegistrationViewState { get }
    func didRequestRegisteringBiometrics() async
    func didRequestNotNow()
}

@Observable
final class LiveBiometricRegistrationViewModel: BiometricRegistrationViewModel {
    private(set) var viewState: BiometricRegistrationViewState = .registering
    private let router: NavigationRouter
    private let biometricStorage: BiometricStorage
    private let inMemoryStorage: InMemoryStorage
    private let localStorage: LocalStorage
    private let biometricAccessProvider: BiometricAccessProvider

    init(
        router: NavigationRouter,
        biometricStorage: BiometricStorage,
        inMemoryStorage: InMemoryStorage,
        localStorage: LocalStorage,
        biometricAccessProvider: BiometricAccessProvider
    ) {
        self.router = router
        self.biometricStorage = biometricStorage
        self.inMemoryStorage = inMemoryStorage
        self.localStorage = localStorage
        self.biometricAccessProvider = biometricAccessProvider
    }

    @MainActor func didRequestRegisteringBiometrics() async {
        guard let token = inMemoryStorage.getValue(forKey: .refreshToken) as? String else {
            viewState = .error("Missing refresh token")
            router.show(route: MainAppRoute.signIn, withData: nil, introspective: true)
            return
        }

        viewState = .registering

        let biometrics = biometricAccessProvider.getSupportedBiometricsType()
        guard biometrics.isBiometryEnabled else {
            viewState = .error("Biometrics not enabled.")
            return
        }

        do {
            if await biometricAccessProvider.requestPermissionToAccessBiometrics(for: biometrics) {
                try await biometricStorage.store(value: token, at: .refreshToken)
                try localStorage.setValue(true, forKey: StorageKeys.biometricsSetUp.rawValue)
                viewState = .success
                router.show(route: MainAppRoute.lobby, withData: nil, introspective: true)
            } else {
                viewState = .error("Biometric authentication denied.")
                return
            }
        } catch {
            viewState = .error("Unable to setup biometry. Try Again.")
        }
    }

    func didRequestNotNow() {
        router.show(route: MainAppRoute.lobby, withData: nil, introspective: true)
    }
}

private extension LiveBiometricRegistrationViewModel {}
