//
//  VideoOnboardingFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

public enum VideoOnboardingFeatureFactory {
    public static func makeOnboargingFeature(
        navigator: Navigator,
        parentFlow: FlowCoordinator? = nil,
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        VideoOnboardingFlowCoordinator(
            navigator: navigator,
            parent: parentFlow,
            dependencyProvider: dependencyProvider,
            viewFactories: [VideoOnboardingFlowViewFactory(dependencyProvider: dependencyProvider)],
            coordinatorFactories: []
        )
    }
}
