//
//  SignUpFlowCoordinator.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

final class SignUpFlowCoordinator: FlowCoordinator {
    let parent: FlowCoordinator?
    let navigator: Navigator
    let viewFactories: [ViewComponentFactory]
    let coordinatorFactories: [FlowCoordinatorFactory]
    var completionCallback: (() -> Void)?
    weak var adaptivePresentationDelegate: UIAdaptivePresentationControllerDelegate?
    var child: FlowCoordinator?

    private let dependencyProvider: DependencyProvider

    init(
        navigator: Navigator,
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared,
        parent: FlowCoordinator? = nil,
        viewFactories: [ViewComponentFactory]? = nil,
        coordinatorFactories: [FlowCoordinatorFactory]? = nil
    ) {
        self.navigator = navigator
        self.dependencyProvider = dependencyProvider
        self.parent = parent
        self.viewFactories = viewFactories ?? [SignUpFlowViewFactory(dependencyProvider: dependencyProvider)]
        self.coordinatorFactories = coordinatorFactories ?? [SignUpFlowCoordinatorFactory(dependencyProvider: dependencyProvider)]
    }

    func start(animated: Bool) {
        let initialRoute = SignUpRoute.emailEntry
        let emailEntry = makeViewComponents(forRoute: initialRoute, withData: nil)[0]
        emailEntry.route = initialRoute
        navigator.pushViewController(emailEntry.viewController, animated: animated)
        initialInternalRoute = initialRoute
    }

    func stop() {
        child?.stop()
        child = nil
        cleanUpNavigationStack()
        completionCallback?()
    }

    func canShow(route: any Route) -> Bool {
        route as? SignUpRoute != nil
    }
}
