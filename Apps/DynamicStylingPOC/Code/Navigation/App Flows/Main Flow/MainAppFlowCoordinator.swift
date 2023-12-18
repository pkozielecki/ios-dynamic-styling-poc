//
//  MainAppFlowCoordinator.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

final class MainAppFlowCoordinator: FlowCoordinator {
    let parent: FlowCoordinator?
    let navigator: Navigator
    var completionCallback: (() -> Void)?
    var adaptivePresentationDelegate: UIAdaptivePresentationControllerDelegate?
    var child: FlowCoordinator? = nil

    init(
        navigator: Navigator,
        parent: FlowCoordinator? = nil
    ) {
        self.navigator = navigator
        self.parent = parent
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
            return [makeWelcomeScreen()]

        default:
            fatalError("Route \(route) is not supported by MainAppFlowCoordinator")
        }
    }

    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, withData: AnyHashable?) -> FlowCoordinator {
        guard let route = route as? MainAppRoute else {
            fatalError("Flow \(route) is not supported by MainAppFlowCoordinator")
        }

        switch route {
        case .signUp:
            let flowCoordinator = SignUpFlowCoordinator(navigator: navigator, parent: self)
            child = flowCoordinator
            return flowCoordinator

        case .signIn:
            let flowCoordinator = SignInFlowCoordinator(navigator: navigator, parent: self)
            child = flowCoordinator
            return flowCoordinator

        default:
            fatalError("Flow \(route) is not supported by MainAppFlowCoordinator")
        }
    }
}

private extension MainAppFlowCoordinator {
    func makeWelcomeScreen() -> UIViewController {
        let viewModel = LiveWelcomeViewModel(router: resolve())
        return WelcomeView(viewModel: viewModel).viewController
    }
}
