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
        dependenciesRegistrator.register(LiveNavigationRouter(), for: NavigationRouter.self)
        dependenciesRegistrator.register(LiveAppStyleProvider(initialDesignSystem: designSystem), for: AppStyleProvider.self)
    }
}
