//
//  FlowCoordinatorFactory.swift
//  Dynamic Styling POC
//

import Foundation

public protocol FlowCoordinatorFactory {
    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData data: AnyHashable?) -> FlowCoordinator?
}

extension [FlowCoordinatorFactory] {
    public func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, parent: FlowCoordinator?, withData data: AnyHashable?) -> FlowCoordinator? {
        for factory in self {
            if let coordinator = factory.makeFlowCoordinator(forRoute: route, navigator: navigator, parent: parent, withData: data) {
                return coordinator
            }
        }
        return nil
    }
}
