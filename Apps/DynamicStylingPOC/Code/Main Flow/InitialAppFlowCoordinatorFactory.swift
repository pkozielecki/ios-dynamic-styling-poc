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
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        let viewFactories = [MainAppFlowViewFactory(dependencyProvider: dependencyProvider)]
        let coordinatorFactories = [MainAppFlowCoordinatorFactory(dependencyProvider: dependencyProvider)]
        return MainAppFlowCoordinator(
            navigator: rootNavigationController,
            parent: nil,
            dependencyProvider: dependencyProvider,
            viewFactories: viewFactories,
            coordinatorFactories: coordinatorFactories
        )
    }
}
