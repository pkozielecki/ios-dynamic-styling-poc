//
//  CustomOnboardingFlowViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import OnboardingFeature
import SwiftUI
import UIKit

struct CustomOnboardingFlowViewFactory: ViewComponentFactory {
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

private extension CustomOnboardingFlowViewFactory {
    func makeWelcomeScreen() -> UIViewController {
        let viewModel = LiveWelcomeViewModel(router: dependencyProvider.resolve())
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return CustomWelcomeView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }

    func makeOnboardingScreen() -> UIViewController {
        let viewModel = LiveOnboardingViewModel(
            router: dependencyProvider.resolve(),
            storage: dependencyProvider.resolve()
        )
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return CustomOnboardingView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }
}
