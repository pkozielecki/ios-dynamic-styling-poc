//
//  FakeRouter.swift
//  Dynamic Styling POC
//

import CommonUI

public final class FakeNavigationRouter: NavigationRouter {
    public var currentFlow: FlowCoordinator?

    public func show(route: any Route, withData: AnyHashable?) {}

    public func `switch`(toRoute route: any Route, withData: AnyHashable?) {}

    public func navigateBack(animated: Bool) {}

    public func stopCurrentFlow() {}

    public func navigateBackToRoot(animated: Bool) {}

    public func navigateBack(toRoute route: any Route, animated: Bool) {}

    public func start(initialFlow: FlowCoordinator, animated: Bool) {}
}
