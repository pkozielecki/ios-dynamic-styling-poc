//
//  VideoOnboardingViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct VideoOnboardingFlowViewFactory: ViewComponentFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        switch route.name {
        case VideoOnboardingRoute.onboarding.name:
            [makeOnboardingScreen().viewController]
        default:
            []
        }
    }
}

private extension VideoOnboardingFlowViewFactory {
    func makeOnboardingScreen() -> UIViewController {
        let viewModel = LiveVideoOnboardingViewModel(
            router: dependencyProvider.resolve(),
            storage: dependencyProvider.resolve()
        )
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return VideoOnboardingView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }
}
