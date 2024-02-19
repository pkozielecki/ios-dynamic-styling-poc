//
//  NavigationRouter.swift
//  Dynamic Styling POC
//

import Foundation

// sourcery: AutoMockable
public protocol NavigationRouter: AnyObject {
    var currentFlow: FlowCoordinator? { get }

    func show(route: any Route, withData: AnyHashable?)
    func `switch`(toRoute route: any Route, withData: AnyHashable?)
    func navigateBack(animated: Bool)
    func stopCurrentFlow()
    func navigateBackToRoot(animated: Bool)
    func navigateBack(toRoute route: any Route, animated: Bool)
    func start(initialFlow: FlowCoordinator, animated: Bool)
}

public final class LiveNavigationRouter: NavigationRouter {
    private var initialFlow: FlowCoordinator?

    public init() {}

    public func start(initialFlow: FlowCoordinator, animated: Bool) {
        self.initialFlow = initialFlow
        initialFlow.start(animated: animated)
    }

    public func show(route: any Route, withData: AnyHashable?) {
        if currentFlow?.canShow(route: route) == true {
            currentFlow?.show(route: route, withData: withData)
        }
    }

    public func `switch`(toRoute route: any Route, withData: AnyHashable?) {
        currentFlow?.switch(toRoute: route, withData: withData)
    }

    public func navigateBack(animated: Bool) {
        currentFlow?.navigateBack(animated: animated)
    }

    public func navigateBackToRoot(animated: Bool) {
        currentFlow?.navigateBackToRoot(animated: animated, dismissPopup: true)
    }

    public func navigateBack(toRoute route: any Route, animated: Bool) {
        currentFlow?.navigateBack(toRoute: route, animated: animated, dismissPopup: true)
    }

    public func stopCurrentFlow() {
        currentFlow?.stop()
    }
}

public extension LiveNavigationRouter {
    var currentFlow: FlowCoordinator? {
        getCurrentFlow(base: initialFlow)
    }
}

private extension LiveNavigationRouter {
    func getCurrentFlow(base: FlowCoordinator?) -> FlowCoordinator? {
        if let child = base?.child {
            return getCurrentFlow(base: child)
        }
        return base
    }
}
