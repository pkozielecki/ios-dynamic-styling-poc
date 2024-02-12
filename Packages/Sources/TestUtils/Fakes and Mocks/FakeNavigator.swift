//
//  FakeNavigator.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import UIKit

public final class FakeNavigator: Navigator {
    public var simulatedNavigationStack: UINavigationController?
    public var simulatedTopViewController: UIViewController?
    public var simulatedVisibleViewController: UIViewController?
    public var simulatedViewControllers: [UIViewController] = []
    public var simulatedIsNavigationBarHidden: Bool?
    public var simulatedPresentedViewController: UIViewController?
    public var simulatedPresentationController: UIPresentationController?
    public weak var delegate: UINavigationControllerDelegate?

    public private(set) var lastPushedViewController: UIViewController?
    public private(set) var lastPushedViewControllerAnimation: Bool?
    public private(set) var lastPoppedToViewControllerAnimation: Bool?
    public private(set) var lastPoppedToViewController: UIViewController?
    public private(set) var lastPresentedViewController: UIViewController?
    public private(set) var lastPresentedViewControllerAnimation: Bool?
    public private(set) var lastDismissedViewControllerAnimation: Bool?

    public init() {}

    public var navigationStack: UINavigationController {
        simulatedNavigationStack ?? UINavigationController()
    }

    public var topViewController: UIViewController? {
        simulatedTopViewController
    }

    public var visibleViewController: UIViewController? {
        simulatedVisibleViewController
    }

    public var viewControllers: [UIViewController] {
        simulatedViewControllers
    }

    public var isNavigationBarHidden: Bool {
        simulatedIsNavigationBarHidden ?? false
    }

    public var presentedViewController: UIViewController? {
        simulatedPresentedViewController
    }

    public var presentationController: UIPresentationController? {
        simulatedPresentationController
    }

    public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        simulatedViewControllers.append(viewController)
        lastPushedViewController = viewController
        lastPushedViewControllerAnimation = animated
    }

    public func popViewController(animated: Bool) -> UIViewController? {
        if !simulatedViewControllers.isEmpty {
            simulatedViewControllers.removeLast()
        }
        lastPoppedToViewControllerAnimation = animated
        return nil
    }

    public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        lastPoppedToViewController = viewController
        lastPoppedToViewControllerAnimation = animated
        let index = simulatedViewControllers.firstIndex(of: viewController) ?? 0
        simulatedViewControllers = Array(simulatedViewControllers[0...index])
        return nil
    }

    public func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        simulatedPresentedViewController = viewControllerToPresent
        lastPresentedViewController = viewControllerToPresent
        lastPresentedViewControllerAnimation = flag
        completion?()
    }

    public func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        simulatedPresentedViewController = nil
        lastDismissedViewControllerAnimation = flag
        completion?()
    }

    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        simulatedViewControllers = viewControllers
    }

    public func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        simulatedIsNavigationBarHidden = hidden
    }
}

public extension FakeNavigator {
    func simulateBackButtonTapped(viewToPopTo view: UIViewController, animated: Bool = false) {
        _ = simulatedViewControllers.popLast()
        delegate?.navigationController?(navigationStack, didShow: view, animated: animated)
    }
}
