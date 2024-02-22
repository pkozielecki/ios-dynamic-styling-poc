//
//  MainAppFlowCoordinatorFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import OnboardingFeature
import SignInFeature
import SignUpFeature
import SwiftUI
import UIKit
import VideoOnboardingFeature

struct MainAppFlowCoordinatorFactory: FlowCoordinatorFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData: AnyHashable?) -> FlowCoordinator? {
        switch route.name {
        case MainAppRoute.signUp.name:
            SignUpFeatureFactory.makeSignUpFlowCoordinator(
                navigator: navigator,
                parentFlow: parent,
                viewFactories: parent?.viewFactories ?? [],
                coordinatorFactories: parent?.coordinatorFactories ?? [],
                dependencyProvider: dependencyProvider
            )

        case MainAppRoute.signIn.name:
            SignInFeatureFactory.makeSignInFlowCoordinator(
                navigator: navigator,
                parentFlow: parent,
                viewFactories: parent?.viewFactories ?? [],
                coordinatorFactories: parent?.coordinatorFactories ?? [],
                dependencyProvider: dependencyProvider
            )

        case MainAppRoute.onboarding.name:
            OnboardingFeatureFactory.makeOnboargingFeature(
                navigator: navigator,
                parentFlow: parent,
                viewFactories: parent?.viewFactories ?? [],
                dependencyProvider: dependencyProvider
            )
            // Discussion: Uncomment for video onboarding:
            /*
            VideoOnboardingFeatureFactory.makeOnboargingFeature(
                navigator: navigator,
                parentFlow: parent,
                dependencyProvider: dependencyProvider
            )
             */

        default:
            nil
        }
    }
}
