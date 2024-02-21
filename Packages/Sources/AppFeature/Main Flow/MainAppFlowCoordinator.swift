//
//  MainAppFlowCoordinator.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import OnboardingFeature
import SignInFeature
import SignUpFeature
import SwiftUI
import UIKit

final class MainAppFlowCoordinator: FlowCoordinator {
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
        parent: FlowCoordinator? = nil,
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared,
        viewFactories: [ViewComponentFactory]? = nil,
        coordinatorFactories: [FlowCoordinatorFactory]? = nil
    ) {
        self.navigator = navigator
        self.parent = parent
        self.dependencyProvider = dependencyProvider
        self.viewFactories = viewFactories ?? [MainAppFlowViewFactory(dependencyProvider: dependencyProvider)]
        self.coordinatorFactories = coordinatorFactories ?? [MainAppFlowCoordinatorFactory(dependencyProvider: dependencyProvider)]
    }

    func start(animated: Bool) {
        let initialRoute = MainAppRoute.splashScreen
        let welcomeScreen = makeViewComponents(forRoute: initialRoute, withData: nil)[0]
        welcomeScreen.route = initialRoute
        navigator.pushViewController(welcomeScreen.viewController, animated: animated)
        initialInternalRoute = initialRoute
    }

    func stop() {
        child?.stop()
        child = nil
        cleanUpNavigationStack()
        completionCallback?()
    }

    func canShow(route: any Route) -> Bool {
        route as? MainAppRoute != nil
    }
}
