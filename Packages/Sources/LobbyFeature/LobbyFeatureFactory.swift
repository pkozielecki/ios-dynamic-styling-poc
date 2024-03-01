//
//  LobbyFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

public enum LobbyFeatureFactory {
    public static func makeLobbyFeature(
        navigator: Navigator,
        parentFlow: FlowCoordinator? = nil,
        viewFactories: [ViewComponentFactory] = [],
        coordinatorFactories: [FlowCoordinatorFactory] = [],
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        LobbyFlowCoordinator(
            navigator: navigator,
            parent: parentFlow,
            dependencyProvider: dependencyProvider,
            viewFactories: LobbyFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: viewFactories),
            coordinatorFactories: coordinatorFactories // Discussion: Lobby Flow does not start any child flows initially.
        )
    }
}
