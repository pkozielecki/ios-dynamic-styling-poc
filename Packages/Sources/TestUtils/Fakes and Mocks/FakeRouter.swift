//
//  FakeRouter.swift
//  Dynamic Styling POC
//

import CommonUI

public final class FakeNavigationRouter: NavigationRouter {
    public private(set) var lastShownRoute: (any Route)?
    public private(set) var lestShownRouteData: AnyHashable?

    public var currentFlow: FlowCoordinator?

    public init() {}

    public func show(route: any Route, withData: AnyHashable?) {
        lastShownRoute = route
        lestShownRouteData = withData
    }

    public func `switch`(toRoute route: any Route, withData: AnyHashable?) {}

    public func navigateBack(animated: Bool) {}

    public func stopCurrentFlow() {}

    public func navigateBackToRoot(animated: Bool) {}

    public func navigateBack(toRoute route: any Route, animated: Bool) {}

    public func start(initialFlow: FlowCoordinator, animated: Bool) {}
}
