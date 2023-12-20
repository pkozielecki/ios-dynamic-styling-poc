//
//  SignInFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import UIKit

public enum SignInFeatureFactory {
    public static func makeSignInFlowCoordinator(
        navigator: Navigator,
        parentFlow: FlowCoordinator?
    ) -> FlowCoordinator {
        SignInFlowCoordinator(navigator: navigator, parent: parentFlow)
    }
}
