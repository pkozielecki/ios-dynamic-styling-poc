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
        dependencyManager?.register(networkModule, for: NetworkModule.self)
        dependencyManager?.register(LiveNavigationRouter(), for: NavigationRouter.self)
        dependencyManager?.register(appStyleProvider, for: AppStyleProvider.self)
    }
}

extension AppDesignSystem {
    static var `default`: AppDesignSystem {
        AppDesignSystem(
            colors: .default,
            fonts: .default
        )
    }
}

extension AppColors {
    static var `default`: AppColors {
        AppColors(
            error500: .init(named: "Error500"),
            informative500: .init(named: "Informative500"),
            neutral500: .init(named: "Neutral500"),
            primary100: .init(named: "Primary100"),
            primary500: .init(named: "Primary500"),
            primary900: .init(named: "Primary900"),
            secondary100: .init(named: "Secondary100"),
            secondary500: .init(named: "Secondary500"),
            secondary900: .init(named: "Secondary900"),
            success500: .init(named: "Success500"),
            tertiary100: .init(named: "Tertiary100"),
            text500: .init(named: "Text500"),
            warning500: .init(named: "Warning500"),
            clear: .init(light: .clear, dark: .clear)
        )
    }
}
