//
//  SignInFlowCoordinator.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

final class SignInFlowCoordinator: FlowCoordinator {
    let parent: FlowCoordinator?
    let navigator: Navigator
    var completionCallback: (() -> Void)?
    weak var adaptivePresentationDelegate: UIAdaptivePresentationControllerDelegate?
    var child: FlowCoordinator?

    private let dependencyProvider: DependencyProvider
    private let viewFactories: [ViewComponentFactory]
    private let coordinatorFactories: [FlowCoordinatorFactory]

    init(
        navigator: Navigator,
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared,
        parent: FlowCoordinator? = nil,
        viewFactories: [ViewComponentFactory] = [SignInFlowViewFactory()],
        coordinatorFactories: [FlowCoordinatorFactory] = [SignInFlowCoordinatorFactory()]
    ) {
        self.navigator = navigator
        self.dependencyProvider = dependencyProvider
        self.parent = parent
        self.viewFactories = viewFactories
        self.coordinatorFactories = coordinatorFactories
    }

    func start(animated: Bool) {
        let initialRoute = SignInRoute.emailPasswordLogin
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
        route as? SignInRoute != nil
    }

    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        viewFactories.makeViewComponents(forRoute: route, withData: data)
    }
}
