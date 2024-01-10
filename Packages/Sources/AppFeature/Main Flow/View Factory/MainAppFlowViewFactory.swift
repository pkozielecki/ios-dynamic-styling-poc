//
//  MainAppFlowViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct MainAppFlowViewFactory: ViewComponentFactory {
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
        let viewModel = LiveWelcomeViewModel(router: resolve())
        return WelcomeView(viewModel: viewModel).viewController
    }
}
