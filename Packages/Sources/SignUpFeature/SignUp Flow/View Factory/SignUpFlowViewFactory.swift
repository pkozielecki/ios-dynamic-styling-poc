//
//  SignUpFlowViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct SignUpFlowViewFactory: ViewComponentFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        switch route.name {
        case SignUpRoute.emailEntry.name:
            return [makeEmailEntryScreen()]
        case SignUpRoute.passwordEntry.name:
            if let email = data as? String {
                return [makePasswordEntryScreen(email: email)]
            }
            return []
        default:
            return []
        }
    }
}

private extension SignUpFlowViewFactory {
    func makeEmailEntryScreen() -> UIViewController {
        let model = LiveEmailEntryViewModel(router: dependencyProvider.resolve())
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return EmailEntryView(viewModel: model, appStyleProvider: appStyleProvider).viewController
    }

    func makePasswordEntryScreen(email: String) -> UIViewController {
        let model = LivePasswordEntryViewModel(email: email, router: dependencyProvider.resolve())
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return PasswordEntryView(viewModel: model, appStyleProvider: appStyleProvider).viewController
    }
}
