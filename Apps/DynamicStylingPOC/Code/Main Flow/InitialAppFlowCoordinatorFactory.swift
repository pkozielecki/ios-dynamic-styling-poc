//
//  InitialAppFlowCoordinatorFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

enum InitialAppFlowCoordinatorFactory {
    static func makeInitialFlow(
        rootNavigationController: RootNavigationController,
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared,
        viewFactories: [ViewComponentFactory] = [],
        coordinatorFactories: [FlowCoordinatorFactory] = []
    ) -> FlowCoordinator {
        let viewFactories = MainAppFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: viewFactories)
        let coordinatorFactories = MainAppFlowCoordinatorFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: coordinatorFactories)
        return MainAppFlowCoordinator(
            navigator: rootNavigationController,
            parent: nil,
            dependencyProvider: dependencyProvider,
            viewFactories: viewFactories,
            coordinatorFactories: coordinatorFactories
        )
    }
}
