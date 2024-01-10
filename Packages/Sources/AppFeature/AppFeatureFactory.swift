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
        coordinatorFactory: FlowCoordinatorFactory? = nil
    ) -> FlowCoordinator {
        MainAppFlowCoordinator(
            navigator: navigator,
            parent: parentFlow,
            viewFactories: MainAppFlowViewFactory().combine(withCustomFactory: viewFactory),
            coordinatorFactories: MainAppFlowCoordinatorFactory().combine(withCustomFactory: coordinatorFactory)
        )
    }
}
