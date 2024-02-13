//
//  SignInFlowViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct SignInFlowViewFactory: ViewComponentFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        switch route.name {
        case SignInRoute.emailPasswordLogin.name:
            [makeEmailLoginScreen().viewController]
        default:
            []
        }
    }
}

private extension SignInFlowViewFactory {
    func makeEmailLoginScreen() -> UIViewController {
        let model = LiveEmailPasswordLoginViewModel(router: dependencyProvider.resolve())
        return EmailPasswordLoginView(viewModel: model).viewController
    }
}
