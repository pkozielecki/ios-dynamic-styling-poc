//
//  Navigator.swift
//  Dynamic Styling POC
//

import UIKit

public protocol Navigator: AnyObject {
    var navigationStack: UINavigationController { get }
    var topViewController: UIViewController? { get }
    var visibleViewController: UIViewController? { get }
    var viewControllers: [UIViewController] { get }
    var isNavigationBarHidden: Bool { get }
    var presentedViewController: UIViewController? { get }
    var presentationController: UIPresentationController? { get }
    var delegate: UINavigationControllerDelegate? { get set }

    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool) -> UIViewController?
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    func setNavigationBarHidden(_ hidden: Bool, animated: Bool)
}

public extension Navigator {
    func contains(route: any Route) -> Bool {
        viewControllers.filter { $0.route.matches(route) }.isEmpty == false
    }

    func index(for route: any Route) -> Int? {
        viewControllers.firstIndex { $0.route.matches(route) }
    }
}

extension UINavigationController: Navigator {
    public var navigationStack: UINavigationController {
        self
    }
}
