//
//  FakeDependencyProvider.swift
//  Dynamic Styling POC
//

import Common

public final class FakeDependencyProvider: DependencyProvider {
    var dependencies: [String: Any] = [:]

    public init(dependencies: [String: Any]) {
        self.dependencies = dependencies
    }

    public func resolve<T>() -> T {
        let id = String(describing: T.self)
        if let dependency = dependencies[id] as? T {
            return dependency
        } else {
            fatalError("No dependency found for \(id)! You have to register that dependency first!")
        }
    }
}
