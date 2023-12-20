//
//  AppFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

public enum AppFeatureFactory {
    public static func makeAppFeature(
        navigator: Navigator,
        parentFlow: FlowCoordinator?
    ) -> FlowCoordinator {
        MainAppFlowCoordinator(navigator: navigator, parent: parentFlow)
    }
}
