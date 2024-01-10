//
//  MainAppFlowViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct MainAppFlowViewFactory: ViewFactory {
    func makeView(for route: any Route) -> UIViewController? {
        switch route.name {
        case MainAppRoute.welcome.name:
            makeWelcomeScreen()
        default:
            nil
        }
    }
}

private extension MainAppFlowViewFactory {
    func makeWelcomeScreen() -> UIViewController {
        let viewModel = LiveWelcomeViewModel(router: resolve())
        return WelcomeView(viewModel: viewModel).viewController
    }
}
