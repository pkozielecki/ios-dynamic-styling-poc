//
//  DependenciesInitializer.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation

struct DependenciesInitializer {
    private let dependenciesRegistrator: DependencyManager
    private let designSystem: AppDesignSystem

    init(
        designSystem: AppDesignSystem,
        dependenciesRegistrator: DependencyManager = LiveDependencyManager.shared as! DependencyManager
    ) {
        self.dependenciesRegistrator = dependenciesRegistrator
        self.designSystem = designSystem
    }

    func registerDependencies() {
        let networkModule = NetworkingFactory.makeNetworkModule(baseURL: URL(string: "https://whg.com")!)
        let appStyleProvider = LiveAppStyleProvider(
            appStyleSynchroniser: LiveAppStyleSynchroniser(networkModule: networkModule),
            initialDesignSystem: designSystem
        )
        dependenciesRegistrator.register(networkModule, for: NetworkModule.self)
        dependenciesRegistrator.register(LiveNavigationRouter(), for: NavigationRouter.self)
        dependenciesRegistrator.register(appStyleProvider, for: AppStyleProvider.self)
    }
}
