//
//  NavigationStackChangesHandler.swift
//  Dynamic Styling POC
//

import UIKit

final class NavigationStackChangesHandler: NSObject, UINavigationControllerDelegate {
    private let onRouteShown: ((any Route) -> Void)?

    init(onRouteShown: ((any Route) -> Void)?) {
        self.onRouteShown = onRouteShown
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        onRouteShown?(viewController.route)
    }
}
