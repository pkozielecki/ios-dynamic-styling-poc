//
//  MainAppFlowCoordinatorFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SignInFeature
import SignUpFeature
import SwiftUI
import UIKit

struct MainAppFlowCoordinatorFactory: FlowCoordinatorFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData: AnyHashable?) -> FlowCoordinator? {
        switch route.name {
        case MainAppRoute.signUp.name:
            SignUpFeatureFactory.makeSignUpFlowCoordinator(navigator: navigator, parentFlow: parent)

        case MainAppRoute.signIn.name:
            SignInFeatureFactory.makeSignInFlowCoordinator(navigator: navigator, parentFlow: parent)

        default:
            nil
        }
    }
}
