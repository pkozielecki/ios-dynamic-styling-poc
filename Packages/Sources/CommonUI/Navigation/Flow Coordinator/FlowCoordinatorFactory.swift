//
//  FlowCoordinatorFactory.swift
//  Dynamic Styling POC
//

import Foundation

public protocol FlowCoordinatorFactory {
    func makeFlowCoordinator(forRoute route: any Route, navigator: Navigator, withData: AnyHashable?) -> FlowCoordinator
}
