//
//  SignInFlowCoordinatorFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct SignInFlowCoordinatorFactory: FlowCoordinatorFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData: AnyHashable?) -> FlowCoordinator? {
        // Discussion: No flows started from this one yet.
        nil
    }
}
