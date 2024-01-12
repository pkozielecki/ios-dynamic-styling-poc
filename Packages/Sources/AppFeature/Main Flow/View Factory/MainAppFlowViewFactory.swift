//
//  MainAppFlowViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct MainAppFlowViewFactory: ViewComponentFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        switch route.name {
        case MainAppRoute.welcome.name:
            [makeWelcomeScreen().viewController]
        default:
            []
        }
    }
}

private extension MainAppFlowViewFactory {
    func makeWelcomeScreen() -> UIViewController {
        let viewModel = LiveWelcomeViewModel(router: dependencyProvider.resolve())
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return WelcomeView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }
}
