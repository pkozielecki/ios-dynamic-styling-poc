//
//  SignUpFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import UIKit

public enum SignUpFeatureFactory {
    public static func makeSignUpFlowCoordinator(
        navigator: Navigator,
        parentFlow: FlowCoordinator?
    ) -> FlowCoordinator {
        SignUpFlowCoordinator(navigator: navigator, parent: parentFlow)
    }
}
