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
    private let dependencyProvider: DependencyProvider
    var completionCallback: (() -> Void)?
    var adaptivePresentationDelegate: UIAdaptivePresentationControllerDelegate?
    var child: FlowCoordinator? = nil

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

    func makeViewComponents(forRoute route: any Route, withData: AnyHashable?) -> [ViewComponent] {
        guard let route = route as? SignUpRoute else {
            fatalError("Route \(route) is not supported by SignUpFlowCoordinator")
        }

        switch route {
        case .emailEntry:
            return [makeEmailEntryScreen()]
        case .passwordEntry:
            return [makePasswordEntryScreen()]
        }
    }

    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, withData: AnyHashable?) -> FlowCoordinator {
        fatalError("Flow \(route) is not supported by SignUpFlowCoordinator")
    }
}

private extension SignUpFlowCoordinator {
    func makeEmailEntryScreen() -> UIViewController {
        let model = LiveEmailEntryViewModel(router: dependencyProvider.resolve())
        return EmailEntryView(viewModel: model).viewController
    }

    func makePasswordEntryScreen() -> UIViewController {
        let model = LivePasswordEntryViewModel(router: dependencyProvider.resolve())
        return PasswordEntryView(viewModel: model).viewController
    }
}
