//
//  VideoOnboardingFlowCoordinator.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

final class VideoOnboardingFlowCoordinator: FlowCoordinator {
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
        self.viewFactories = viewFactories ?? [VideoOnboardingFlowViewFactory(dependencyProvider: dependencyProvider)]
        self.coordinatorFactories = coordinatorFactories ?? []
    }

    func start(animated: Bool) {
        let initialRoute = VideoOnboardingRoute.onboarding
        let onboardingScreen = makeViewComponents(forRoute: initialRoute, withData: nil)[0]
        onboardingScreen.route = initialRoute
        navigator.pushViewController(onboardingScreen.viewController, animated: animated)
        initialInternalRoute = initialRoute
    }

    func stop() {
        child?.stop()
        child = nil
        cleanUpNavigationStack()
        completionCallback?()
    }

    func canShow(route: any Route) -> Bool {
        route as? VideoOnboardingRoute != nil
    }
}
