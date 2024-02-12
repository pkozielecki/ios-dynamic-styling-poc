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
        viewFactory: ViewComponentFactory? = nil,
        coordinatorFactory: FlowCoordinatorFactory? = nil,
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        MainAppFlowCoordinator(
            navigator: navigator,
            parent: parentFlow,
            dependencyProvider: dependencyProvider,
            viewFactories: MainAppFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactory: viewFactory),
            coordinatorFactories: MainAppFlowCoordinatorFactory(dependencyProvider: dependencyProvider).combine(withCustomFactory: coordinatorFactory)
        )
    }
}
