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
        viewFactory: ViewComponentFactory? = nil,
        coordinatorFactory: FlowCoordinatorFactory? = nil,
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        SignUpFlowCoordinator(
            navigator: navigator,
            dependencyProvider: dependencyProvider,
            parent: parentFlow,
            viewFactories: SignUpFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactory: viewFactory),
            coordinatorFactories: SignUpFlowCoordinatorFactory(dependencyProvider: dependencyProvider).combine(withCustomFactory: coordinatorFactory)
        )
    }
}
