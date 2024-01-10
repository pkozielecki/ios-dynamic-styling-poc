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
    var completionCallback: (() -> Void)?
    weak var adaptivePresentationDelegate: UIAdaptivePresentationControllerDelegate?
    var child: FlowCoordinator?

    private let viewFactories: [ViewFactory]

    init(
        navigator: Navigator,
        parent: FlowCoordinator? = nil,
        viewFactories: [ViewFactory] = [MainAppFlowViewFactory()]
    ) {
        self.navigator = navigator
        self.parent = parent
        self.viewFactories = viewFactories
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

    func makeViewComponents(forRoute route: any Route, withData: AnyHashable?) -> [ViewComponent] {
        guard let route = route as? MainAppRoute else {
            fatalError("Route \(route) is not supported by MainAppFlowCoordinator")
        }

        switch route {
        case .welcome:
            return [viewFactories.makeView(for: MainAppRoute.welcome)]

        default:
            fatalError("💥 Route \(route) is not supported by MainAppFlowCoordinator")
        }
    }

    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, withData: AnyHashable?) -> FlowCoordinator {
        guard let route = route as? MainAppRoute else {
            fatalError("💥 Flow \(route) is not supported by MainAppFlowCoordinator")
        }

        switch route {
        case .signUp:
            let flowCoordinator = SignUpFeatureFactory.makeSignUpFlowCoordinator(navigator: navigator, parentFlow: self)
            child = flowCoordinator
            return flowCoordinator

        case .signIn:
            let flowCoordinator = SignInFeatureFactory.makeSignInFlowCoordinator(navigator: navigator, parentFlow: self)
            child = flowCoordinator
            return flowCoordinator

        default:
            fatalError("💥 Flow \(route) is not supported by MainAppFlowCoordinator")
        }
    }
}
