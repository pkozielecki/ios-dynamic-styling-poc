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
        let designSystem = AppDesignSystem.default
        let storage = UserDefaults.standard
        let biometricAccessProvider = LiveBiometricAccessProvider()
        let biometricStorage = LiveBiometricStorage()
        let inMemoryStorage = LiveInMemoryStorage()
        let userStatusProvider = LiveUserStatusProvider(storage: storage, inMemoryStorage: inMemoryStorage)
        let appStyleProvider = LiveAppStyleProvider(
            appStyleSynchroniser: LiveAppStyleSynchroniser(networkModule: networkModule),
            initialAppStyle: .init(
                initialDesignSystem: designSystem,
                intialComponents: .default
            )
        )
        dependenciesRegistrator.register(biometricAccessProvider, for: BiometricAccessProvider.self)
        dependenciesRegistrator.register(biometricStorage, for: BiometricStorage.self)
        dependenciesRegistrator.register(inMemoryStorage, for: InMemoryStorage.self)
        dependenciesRegistrator.register(storage, for: LocalStorage.self)
        dependenciesRegistrator.register(networkModule, for: NetworkModule.self)
        dependenciesRegistrator.register(LiveNavigationRouter(), for: NavigationRouter.self)
        dependenciesRegistrator.register(appStyleProvider, for: AppStyleProvider.self)
        dependenciesRegistrator.register(userStatusProvider, for: UserStatusProvider.self)
    }
}
