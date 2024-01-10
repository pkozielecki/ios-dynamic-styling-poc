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
        viewFactory: ViewFactory? = nil
    ) -> FlowCoordinator {
        var factories: [ViewFactory] = [MainAppFlowViewFactory()]
        if let factory = viewFactory {
            factories.insert(factory, at: 0)
        }
        return MainAppFlowCoordinator(navigator: navigator, parent: parentFlow, viewFactories: factories)
    }
}
