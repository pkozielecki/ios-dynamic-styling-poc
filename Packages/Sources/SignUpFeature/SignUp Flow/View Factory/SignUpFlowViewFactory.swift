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
            [makeEmailEntryScreen()]
        case SignUpRoute.passwordEntry.name:
            [makePasswordEntryScreen()]
        default:
            []
        }
    }
}

private extension SignUpFlowViewFactory {
    func makeEmailEntryScreen() -> UIViewController {
        let model = LiveEmailEntryViewModel(router: dependencyProvider.resolve())
        return EmailEntryView(viewModel: model).viewController
    }

    func makePasswordEntryScreen() -> UIViewController {
        let model = LivePasswordEntryViewModel(router: dependencyProvider.resolve())
        return PasswordEntryView(viewModel: model).viewController
    }
}
