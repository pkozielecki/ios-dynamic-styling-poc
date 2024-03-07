//
//  BiometricAuthenticationFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import UIKit

public enum BiometricAuthenticationFeatureWorkMode: Equatable {
    case registration
    case authentication
}

public enum BiometricAuthenticationFeature {
    public static func makeBiometricAuthenticationFlowCoordinator(
        workMode: BiometricAuthenticationFeatureWorkMode,
        navigator: Navigator,
        parentFlow: FlowCoordinator?,
        viewFactories: [ViewComponentFactory] = [],
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        BiometricAuthenticationFlowCoordinator(
            workMode: workMode,
            navigator: navigator,
            parent: parentFlow,
            dependencyProvider: dependencyProvider,
            viewFactories: BiometricAuthenticationFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: viewFactories),
            coordinatorFactories: nil
        )
    }
}
