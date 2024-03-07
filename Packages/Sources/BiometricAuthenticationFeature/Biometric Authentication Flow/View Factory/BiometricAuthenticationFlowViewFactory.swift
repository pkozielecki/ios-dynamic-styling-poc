//
//  BiometricAuthenticationFlowViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct BiometricAuthenticationFlowViewFactory: ViewComponentFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        switch route.name {
        case BiomtricAuthenticationRoute.authentication.name:
            [makeAuthenticationScreen().viewController]
        case BiomtricAuthenticationRoute.registration.name:
            [makeRegistrationScreen().viewController]
        default:
            []
        }
    }
}

private extension BiometricAuthenticationFlowViewFactory {
    func makeAuthenticationScreen() -> UIViewController {
        let viewModel = LiveBiometricAuthenticationViewModel(
            router: dependencyProvider.resolve(),
            biometricStorage: dependencyProvider.resolve(),
            inMemoryStorage: dependencyProvider.resolve(),
            biometricAccessProvider: dependencyProvider.resolve()
        )
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return BiometricAuthenticationView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }

    func makeRegistrationScreen() -> UIViewController {
        let viewModel = LiveBiometricRegistrationViewModel(
            router: dependencyProvider.resolve(),
            biometricStorage: dependencyProvider.resolve(),
            inMemoryStorage: dependencyProvider.resolve(),
            localStorage: dependencyProvider.resolve(),
            biometricAccessProvider: dependencyProvider.resolve()
        )
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return BiometricRegistrationView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }
}
