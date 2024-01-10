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
            viewFactories: makeViewFactories(customViewFactory: viewFactory),
            coordinatorFactories: makeFlowCoordinatorFactories(customFlowCoordinatorFactory: coordinatorFactory)
        )
    }
}

private extension AppFeatureFactory {
    static func makeViewFactories(customViewFactory: ViewComponentFactory?) -> [ViewComponentFactory] {
        var factories: [ViewComponentFactory] = [MainAppFlowViewFactory()]
        if let factory = customViewFactory {
            factories.insert(factory, at: 0)
        }
        return factories
    }

    static func makeFlowCoordinatorFactories(customFlowCoordinatorFactory: FlowCoordinatorFactory?) -> [FlowCoordinatorFactory] {
        var factories: [FlowCoordinatorFactory] = [MainAppFlowCoordinatorFactory()]
        if let factory = customFlowCoordinatorFactory {
            factories.insert(factory, at: 0)
        }
        return factories
    }
}
