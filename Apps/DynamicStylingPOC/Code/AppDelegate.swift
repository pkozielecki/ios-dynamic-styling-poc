//
//  AppDelegate.swift
//  Dynamic Styling POC
//

import Combine
import Common
import CommonUI
import SwiftUI
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var cancellables = [AnyCancellable]()

    override init() {
        let initializer = DependenciesInitializer(designSystem: .default)
        initializer.registerDependencies()
        super.init()
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let rootNavigationController = RootNavigationController()
        let initialFlow = InitialAppFlowCoordinatorFactory.makeInitialFlow(
            rootNavigationController: rootNavigationController
        )
        window = UIWindow()
        window?.rootViewController = rootNavigationController
        router.start(initialFlow: initialFlow, animated: false)
        window?.makeKeyAndVisible()
        return true
    }
}

private extension AppDelegate {
    var router: NavigationRouter {
        dependencyProvider.resolve()
    }

    var dependencyProvider: DependencyProvider {
        LiveDependencyManager.shared
    }
}
