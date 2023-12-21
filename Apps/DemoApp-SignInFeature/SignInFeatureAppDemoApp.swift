//
//  SignInFeatureAppDemoApp.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SignInFeature
import SwiftUI

@main
struct SignInFeatureAppDemoApp: App {
    let navigtor: UINavigationController
    let flow: FlowCoordinator

    init() {
        navigtor = UINavigationController()
        flow = SignInFeatureFactory.makeSignInFlowCoordinator(navigator: navigtor, parentFlow: nil)
        initializeDependencies()
    }

    var body: some Scene {
        WindowGroup {
            navigtor
                .swiftUIView
                .onAppear {
                    flow.start(animated: false)
                }
        }
    }
}

private extension SignInFeatureAppDemoApp {
    func initializeDependencies() {
        let dependencyManager = LiveDependencyManager.shared as? DependencyManager
        dependencyManager?.register(LiveNavigationRouter(), for: NavigationRouter.self)
        // TODO: Add more dependencies if needed.
    }
}
