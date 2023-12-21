//
//  SignUpFeatureDemoAppApp.swift
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

private extension SignUpFeatureDemoApp {
    func initializeDependencies() {
        let dependencyManager = LiveDependencyManager.shared as? DependencyManager
        dependencyManager?.register(LiveNavigationRouter(), for: NavigationRouter.self)
        // TODO: Add more dependencies if needed.
    }
}
