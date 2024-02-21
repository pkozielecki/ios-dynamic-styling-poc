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
        case MainAppRoute.splashScreen.name:
            [makeSplashScreenView().viewController]
        default:
            []
        }
    }
}

private extension MainAppFlowViewFactory {
    func makeSplashScreenView() -> UIViewController {
        let viewModel = LiveSplashScreenViewModel(
            router: dependencyProvider.resolve(),
            userStatusProvider: dependencyProvider.resolve()
        )
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return SplashScreenView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }
}
