//
//  OnboardingViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct OnboardingFlowViewFactory: ViewComponentFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        switch route.name {
        case OnboardingRoute.onboarding.name:
            [makeOnboardingScreen().viewController]
        case OnboardingRoute.welcome.name:
            [makeWelcomeScreen().viewController]
        default:
            []
        }
    }
}

private extension OnboardingFlowViewFactory {
    func makeWelcomeScreen() -> UIViewController {
        let viewModel = LiveWelcomeViewModel(router: dependencyProvider.resolve())
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return WelcomeView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }

    func makeOnboardingScreen() -> UIViewController {
        let viewModel = LiveOnboardingViewModel(
            router: dependencyProvider.resolve(),
            storage: dependencyProvider.resolve()
        )
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return OnboardingView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }
}
