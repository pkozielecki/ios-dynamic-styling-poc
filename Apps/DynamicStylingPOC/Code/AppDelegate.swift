//
//  AppDelegate.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    override init() {
        let initializer = DependenciesInitializer()
        initializer.registerDependencies()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dependencyProvider = LiveDependencyManager.shared
        let router: NavigationRouter = dependencyProvider.resolve()

        let navigationController = UINavigationController()
        let mainAppFlow = MainAppFlowCoordinator(navigator: navigationController)

        window = UIWindow()
        window?.rootViewController = navigationController

        router.start(initialFlow: mainAppFlow, animated: false)

        window?.makeKeyAndVisible()

        return true
    }
}
