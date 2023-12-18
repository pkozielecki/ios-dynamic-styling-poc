//
//  DependenciesInitializer.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation

struct DependenciesInitializer {
    private let dependenciesRegistrator: DependencyManager

    init(
        dependenciesRegistrator: DependencyManager = LiveDependencyManager.shared as! DependencyManager
    ) {
        self.dependenciesRegistrator = dependenciesRegistrator
    }

    func registerDependencies() {
        dependenciesRegistrator.register(LiveNavigationRouter(), for: NavigationRouter.self)
    }
}
