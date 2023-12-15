import Foundation
import Common

struct DependenciesInitializer {
    private let dependenciesRegistrator: DependencyManager

    init(
        dependenciesRegistrator: DependencyManager = LiveDependencyManager.shared as! DependencyManager
    ) {
        self.dependenciesRegistrator = dependenciesRegistrator
    }

    func registerDependencies() {
        // TODO: Register dependencies.
    }
}
