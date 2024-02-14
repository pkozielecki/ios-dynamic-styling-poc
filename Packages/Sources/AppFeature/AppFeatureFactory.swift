//
//  AppFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

public enum AppFeatureFactory {
    // Discussion: This is mostly to avoid exposing Flow Coordinator(s) outside of the module.
    public static func makeAppFeature(
        navigator: Navigator,
        parentFlow: FlowCoordinator? = nil,
        viewFactories: [ViewComponentFactory] = [],
        coordinatorFactories: [FlowCoordinatorFactory] = [],
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        MainAppFlowCoordinator(
            navigator: navigator,
            parent: parentFlow,
            dependencyProvider: dependencyProvider,
            viewFactories: MainAppFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: viewFactories),
            coordinatorFactories: MainAppFlowCoordinatorFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: coordinatorFactories)
        )
    }
}
