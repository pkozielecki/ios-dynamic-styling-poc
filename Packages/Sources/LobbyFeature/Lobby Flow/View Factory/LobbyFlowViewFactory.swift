//
//  LobbyFlowViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

struct LobbyFlowViewFactory: ViewComponentFactory {
    private let dependencyProvider: DependencyProvider

    init(dependencyProvider: DependencyProvider = LiveDependencyManager.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        switch route.name {
        case LobbyRoute.lobby.name:
            [makeLobbyScreen().viewController]
        default:
            []
        }
    }
}

private extension LobbyFlowViewFactory {
    func makeLobbyScreen() -> UIViewController {
        let viewModel = LiveLobbyViewModel(
            router: dependencyProvider.resolve(),
            biometricStorage: dependencyProvider.resolve(),
            inMemoryStorage: dependencyProvider.resolve()
        )
        let appStyleProvider: AppStyleProvider = dependencyProvider.resolve()
        return LobbyView(viewModel: viewModel, appStyleProvider: appStyleProvider).viewController
    }
}
