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
        viewFactory: ViewComponentFactory? = nil,
        coordinatorFactory: FlowCoordinatorFactory? = nil,
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        SignInFlowCoordinator(
            navigator: navigator,
            dependencyProvider: dependencyProvider,
            parent: parentFlow,
            viewFactories: SignInFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactory: viewFactory),
            coordinatorFactories: SignInFlowCoordinatorFactory(dependencyProvider: dependencyProvider).combine(withCustomFactory: coordinatorFactory)
        )
    }
}
