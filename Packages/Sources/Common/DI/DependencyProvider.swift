//
//  DependencyProvider.swift
//  Dynamic Styling POC
//

import Foundation

public protocol DependencyProvider: AnyObject {
    /// Resolves a dependency, based on a provided type.
    ///
    /// - Returns: a resolved dependency.
    func resolve<T>() -> T
}

public protocol DependencyManager: DependencyProvider {
    /// Registers a dependency under a provided protocol / type.
    ///
    /// - Parameters:
    ///   - dependency: a dependency.
    ///   - type: a type under which a dependency will be registered.
    func register<T>(_ dependency: T, for type: T.Type)
}

public func resolve<T>() -> T {
    LiveDependencyManager.shared.resolve()
}

public final class LiveDependencyManager: DependencyManager {
    public static let shared: DependencyProvider = LiveDependencyManager()
    private var dependencies: [String: Any] = [:]

    private init() {}

    public func resolve<T>() -> T {
        let id = String(describing: T.self)
        if let dependency = dependencies[id] as? T {
            return dependency
        } else {
            fatalError("No dependency found for \(id)! You have to register that dependency first!")
        }
    }

    public func register<T>(_ dependency: T, for type: T.Type) {
        let id = String(describing: type)
        dependencies[id] = dependency
    }
}
