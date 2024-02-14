//
//  SignInFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import UIKit

public enum SignInFeatureFactory {
    public static func makeSignInFlowCoordinator(
        navigator: Navigator,
        parentFlow: FlowCoordinator?,
        viewFactories: [ViewComponentFactory] = [],
        coordinatorFactories: [FlowCoordinatorFactory] = [],
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        SignInFlowCoordinator(
            navigator: navigator,
            dependencyProvider: dependencyProvider,
            parent: parentFlow,
            viewFactories: SignInFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: viewFactories),
            coordinatorFactories: SignInFlowCoordinatorFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: coordinatorFactories)
        )
    }
}
