//
//  OnboardingDemoApp.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import OnboardingFeature
import SwiftUI

@main
struct OnboardingDemoApp: App {
    let navigtor: UINavigationController
    let flow: FlowCoordinator

    init() {
        navigtor = UINavigationController()
        flow = OnboardingFeatureFactory.makeOnboargingFeature(navigator: navigtor)
        initializeDependencies()
    }

    var body: some Scene {
        WindowGroup {
            navigtor
                .swiftUIView
                .onAppear {
                    let router: NavigationRouter = resolve()
                    router.start(initialFlow: flow, animated: false)
                }
        }
    }
}

private extension OnboardingDemoApp {
    func initializeDependencies() {
        let dependencyManager = LiveDependencyManager.shared as? DependencyManager
        let storage = UserDefaults(suiteName: "OnboardingDemoApp") ?? .standard
        let userStatusProvider = LiveUserStatusProvider(storage: storage)
        let networkModule = NetworkingFactory.makeNetworkModule(baseURL: URL(string: "https://whg.com")!)
        let appStyleProvider = LiveAppStyleProvider(
            appStyleSynchroniser: LiveAppStyleSynchroniser(networkModule: networkModule),
            initialAppStyle: AppStyle(initialDesignSystem: .default, intialComponents: .default)
        )
        dependencyManager?.register(storage, for: LocalStorage.self)
        dependencyManager?.register(networkModule, for: NetworkModule.self)
        dependencyManager?.register(LiveNavigationRouter(), for: NavigationRouter.self)
        dependencyManager?.register(appStyleProvider, for: AppStyleProvider.self)
        dependencyManager?.register(userStatusProvider, for: UserStatusProvider.self)
    }
}
