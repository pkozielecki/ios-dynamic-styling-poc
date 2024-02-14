//
//  MainAppFlowCoordinator.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
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
        // TODO: Check if the user is authenticated:
        let initialRoute = MainAppRoute.welcome
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

    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        viewFactories.makeViewComponents(forRoute: route, withData: data)
    }

    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData data: AnyHashable?) -> FlowCoordinator? {
        let coordinator = coordinatorFactories.makeFlowCoordinator(forRoute: route, navigator: navigator, parent: parent, withData: data)
        child = coordinator
        return coordinator
    }
}
