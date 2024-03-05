//
//  SignUpFeatureDemoApp.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SignUpFeature
import SwiftUI

@main
struct SignUpFeatureDemoApp: App {
    let navigtor: UINavigationController
    let flow: FlowCoordinator

    init() {
        navigtor = UINavigationController()
        flow = SignUpFeatureFactory.makeSignUpFlowCoordinator(navigator: navigtor, parentFlow: nil)
        // Discussion: Use `viewFactory: CustomSignUpFlowViewFactory()` to inject custom view factory.

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

private extension SignUpFeatureDemoApp {
    func initializeDependencies() {
        let dependencyManager = LiveDependencyManager.shared as? DependencyManager
        let networkModule = NetworkingFactory.makeNetworkModule(baseURL: URL(string: "https://whg.com")!)
        let appStyleProvider = LiveAppStyleProvider(
            appStyleSynchroniser: LiveAppStyleSynchroniser(networkModule: networkModule),
            initialAppStyle: AppStyle(initialDesignSystem: .default, intialComponents: .default)
        )
        dependencyManager?.register(UserDefaults.standard, for: LocalStorage.self)
        dependencyManager?.register(networkModule, for: NetworkModule.self)
        dependencyManager?.register(LiveNavigationRouter(), for: NavigationRouter.self)
        dependencyManager?.register(appStyleProvider, for: AppStyleProvider.self)
    }
}
