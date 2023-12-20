//
//  AppDelegate.swift
//  Dynamic Styling POC
//

import Combine
import Common
import CommonUI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var cancellables = [AnyCancellable]()

    override init() {
        let initializer = DependenciesInitializer(designSystem: .default)
        initializer.registerDependencies()

        super.init()

        subscribeToStyleUpdates()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dependencyProvider = LiveDependencyManager.shared
        let router: NavigationRouter = dependencyProvider.resolve()

        let navigationController = RootNavigationController()
        let mainAppFlow = MainAppFlowCoordinator(navigator: navigationController)

        window = UIWindow()
        window?.rootViewController = navigationController

        router.start(initialFlow: mainAppFlow, animated: false)

        window?.makeKeyAndVisible()

        return true
    }
}

private extension AppDelegate {
    func subscribeToStyleUpdates() {
        let styleProvider: AppStyleProvider = resolve()
        styleProvider.styleDidChange
            .sink {
                // TODO: Notify entire view hierarchy.
                print("🤖 Style updated")
            }
            .store(in: &cancellables)
    }
}
