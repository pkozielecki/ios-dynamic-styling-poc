//
//  FlowCoordinatorFactory.swift
//  Dynamic Styling POC
//

import Foundation

public protocol FlowCoordinatorFactory {
    var id: String { get }
    func makeFlowCoordinator(
        forRoute route: any Route,
        navigator: Navigator,
        parent: FlowCoordinator?,
        withData data: AnyHashable?
    ) -> FlowCoordinator?
}

public extension [FlowCoordinatorFactory] {
    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData data: AnyHashable?) -> FlowCoordinator? {
        for factory in self {
            if let coordinator = factory.makeFlowCoordinator(
                forRoute: route,
                navigator: navigator,
                parent: parent,
                withData: data
            ) {
                return coordinator
            }
        }
        return nil
    }
}

public extension FlowCoordinatorFactory {
    func combine(withCustomFactories factories: [FlowCoordinatorFactory]) -> [FlowCoordinatorFactory] {
        var existingFactories: [any FlowCoordinatorFactory] = [self]
        for factory in factories where !existingFactories.contains(where: { $0.id == factory.id }) {
            existingFactories.insert(factory, at: 0)
        }
        return existingFactories
    }
}

public extension FlowCoordinatorFactory {
    var id: String {
        String(describing: Self.self)
    }
}
