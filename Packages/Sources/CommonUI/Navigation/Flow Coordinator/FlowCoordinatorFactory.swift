//
//  FlowCoordinatorFactory.swift
//  Dynamic Styling POC
//

import Foundation

public protocol FlowCoordinatorFactory {
    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData data: AnyHashable?) -> FlowCoordinator?
}

extension [FlowCoordinatorFactory] {
    // TODO: Find a way to inject factories for view and child flow coords as well.
    public func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData data: AnyHashable?) -> FlowCoordinator? {
        for factory in self {
            if let coordinator = factory.makeFlowCoordinator(forRoute: route, navigator: navigator, parent: parent, withData: data) {
                return coordinator
            }
        }
        return nil
    }
}

extension FlowCoordinatorFactory {
    public func combine(withCustomFactory factory: FlowCoordinatorFactory?) -> [FlowCoordinatorFactory] {
        var factories: [FlowCoordinatorFactory] = [self]
        if let factory {
            factories.insert(factory, at: 0)
        }
        return factories
    }
}
