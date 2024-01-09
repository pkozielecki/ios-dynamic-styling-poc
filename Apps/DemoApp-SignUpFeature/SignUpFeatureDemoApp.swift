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
        dependencyManager?.register(LiveAppStyleProvider(initialDesignSystem: .default), for: AppStyleProvider.self)
    }
}

extension DesignSystem {
    static var `default`: DesignSystem {
        DesignSystem(
            colors: .default,
            fonts: .default,
            fontWights: .default
        )
    }
}

extension AppColors {
    static var `default`: AppColors {
        AppColors(
            error500: Color("Error500"),
            informative500: Color("Informative500"),
            neutral500: Color("Neutral500"),
            primary100: Color("Primary100"),
            primary500: Color("Primary500"),
            primary900: Color("Primary900"),
            secondary100: Color("Secondary100"),
            secondary500: Color("econdary500"),
            secondary900: Color("Secondary900"),
            success500: Color("Success500"),
            tertiary100: Color("Tertiary100"),
            text500: Color("Text500"),
            warning500: Color("Warning500"),
            clear: .clear
        )
    }
}
