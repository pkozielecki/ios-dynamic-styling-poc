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
    private let dependencyProvider: DependencyProvider
    var completionCallback: (() -> Void)?
    weak var adaptivePresentationDelegate: UIAdaptivePresentationControllerDelegate?
    var child: FlowCoordinator?

    init(
        navigator: Navigator,
        dependencyProvider: DependencyProvider = LiveDependencyManager.shared,
        parent: FlowCoordinator? = nil
    ) {
        self.navigator = navigator
        self.dependencyProvider = dependencyProvider
        self.parent = parent
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

    func makeViewComponents(forRoute route: any Route, withData: AnyHashable?) -> [ViewComponent] {
        guard let route = route as? SignInRoute else {
            fatalError("Route \(route) is not supported by SignInFlowCoordinator")
        }

        switch route {
        case .emailPasswordLogin:
            return [makeEmailLoginScreen()]
        }
    }

    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, withData: AnyHashable?) -> FlowCoordinator {
        fatalError("Flow \(route) is not supported by SignInFlowCoordinator")
    }
}

private extension SignInFlowCoordinator {
    func makeEmailLoginScreen() -> UIViewController {
        let model = LiveEmailPasswordLoginViewModel(router: dependencyProvider.resolve())
        return EmailPasswordLoginView(viewModel: model).viewController
    }
}
