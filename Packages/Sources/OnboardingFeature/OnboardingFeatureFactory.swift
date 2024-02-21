//
//  OnboardingFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

public enum OnboardingFeatureFactory {
    public static func makeOnboargingFeature(
        navigator: Navigator,
        parentFlow: FlowCoordinator? = nil,
        viewFactories: [ViewComponentFactory] = [],
        coordinatorFactories: [FlowCoordinatorFactory] = [],
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared
    ) -> FlowCoordinator {
        OnboardingFlowCoordinator(
            navigator: navigator,
            parent: parentFlow,
            dependencyProvider: dependencyProvider,
            viewFactories: OnboardingFlowViewFactory(dependencyProvider: dependencyProvider).combine(withCustomFactories: viewFactories),
            coordinatorFactories: coordinatorFactories // Discussion: Onboarding Flow does not start any child flows.
        )
    }
}
