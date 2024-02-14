//
//  SignUpFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import UIKit

public enum SignUpFeatureFactory {
    public static func makeSignUpFlowCoordinator(
        navigator: Navigator,
        parentFlow: FlowCoordinator?,
        viewFactories: [ViewComponentFactory] = [],
        coordinatorFactories: [FlowCoordinatorFactory] = [],
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        SignUpFlowCoordinator(
            navigator: navigator,
            dependencyProvider: dependencyProvider,
            parent: parentFlow,
            viewFactories: SignUpFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: viewFactories),
            coordinatorFactories: SignUpFlowCoordinatorFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: coordinatorFactories)
        )
    }
}
