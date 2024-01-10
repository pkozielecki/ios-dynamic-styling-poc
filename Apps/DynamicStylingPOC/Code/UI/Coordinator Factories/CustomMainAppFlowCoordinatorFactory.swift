//
//  CustomMainAppFlowCoordinatorFactory.swift
//  Dynamic Styling POC
//

import AppFeature
import Common
import CommonUI
import SignInFeature
import SignUpFeature
import SwiftUI
import UIKit

// Discussion: This is just to demonstrate an ability to hand-craft a particular flow,
// ... to be started from a given app Flow.
struct CustomMainAppFlowCoordinatorFactory: FlowCoordinatorFactory {
    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData data: AnyHashable?) -> FlowCoordinator? {
        switch route.name {
        case MainAppRoute.signUp.name:
            // Discussion: Wrong flow on purpose!
            SignInFeatureFactory.makeSignInFlowCoordinator(navigator: navigator, parentFlow: parent)

        case MainAppRoute.signIn.name:
            // Discussion: Wrong flow on purpose!
            SignUpFeatureFactory.makeSignUpFlowCoordinator(navigator: navigator, parentFlow: parent)

        default:
            nil
        }
    }
}
