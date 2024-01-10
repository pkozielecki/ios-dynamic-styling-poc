//
//  AppDelegate.swift
//  Dynamic Styling POC
//

import AppFeature
import Combine
import Common
import CommonUI
import SwiftUI
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
        let mainAppFlow = AppFeatureFactory.makeAppFeature(navigator: navigationController)
        // Discussion: Use `viewFactory: CustomMainAppFlowViewFactory()` to inject custom view factory.

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
