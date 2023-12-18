//
//  FlowCoordinator.swift
//  Dynamic Styling POC
//

import ObjectiveC
import UIKit

private var flowCoordinatorRouteKey: UInt8 = 234
private var popupDismissHandlerKey: UInt8 = 112
private var navigationStackChangesHandlerKey: UInt8 = 212
private var popupDismissInProgressKey: UInt8 = 113
private var flowCoordinatorInitialInternalRoute: UInt8 = 119

public protocol FlowCoordinator: ViewComponent, ViewComponentFactory, FlowCoordinatorFactory {
    var navigator: Navigator { get }
    var parent: FlowCoordinator? { get }
    var child: FlowCoordinator? { get set }
    var completionCallback: (() -> Void)? { get set }

    func start(animated: Bool)
    func stop()
    func show(route: any Route, withData: AnyHashable?)
    func canShow(route: any Route) -> Bool
    func `switch`(toRoute route: any Route, withData: AnyHashable?)
    func navigateBack(animated: Bool)
    func navigateBackToRoot(animated: Bool, dismissPopup: Bool)
    func navigateBack(toRoute route: any Route, animated: Bool, dismissPopup: Bool)
}

public extension FlowCoordinator {
    var viewController: UIViewController {
        navigator.navigationStack
    }

    var route: any Route {
        get {
            objc_getAssociatedObject(self, &flowCoordinatorRouteKey) as? any Route ?? EmptyRoute()
        }
        set {
            objc_setAssociatedObject(self, &flowCoordinatorRouteKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var initialInternalRoute: (any Route)? {
        get {
            objc_getAssociatedObject(self, &flowCoordinatorInitialInternalRoute) as? any Route
        }
        set {
            objc_setAssociatedObject(self, &flowCoordinatorInitialInternalRoute, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func show(route: any Route, withData: AnyHashable?) {
        guard canShow(route: route) else {
            return
        }
        if initialInternalRoute == nil {
            initialInternalRoute = route
        }

        if route.isFlow {
            if route.isPopup {
                createAndStartFlowOnPopup(withData: withData, route: route)
            } else {
                createAndStartInlineFlow(withData: withData, route: route)
            }
        } else {
            let viewComponents = makeViewComponents(forRoute: route, withData: withData)
            if viewComponents.count == 1, let viewComponent = viewComponents.first {
                // There is only a single view to show (99% of cases):
                viewComponent.route = route
                show(viewComponent: viewComponent, asPopup: route.isPopup)
            } else if !route.isPopup {
                // There are more views to show, but inline (not on a popup):
                showInline(viewComponents: viewComponents)
            } else if let last = viewComponents.last {
                // Discussion: There are more views to show on a popup, but not defined as a flow.
                // It's a hypothetical case, but we handle it anyway:
                show(viewComponent: last, asPopup: true)
            }
        }
    }

    func `switch`(toRoute route: any Route, withData: AnyHashable?) {
        if canShow(route: route) {
            if isShowing(route: route) {
                child?.stop()
                navigateBack(toRoute: route)
            } else {
                // Discussion: If the desired route is NOT a popup and current child flow is displayed on a popup:
                if !route.isPopup, child?.route.isPopup == true {
                    child?.stop()
                }

                navigateBackToRoot(animated: true, dismissPopup: false)
                show(route: route, withData: withData)
            }
        } else if let parent {
            parent.switch(toRoute: route, withData: withData)
        } else {
            fatalError("`Switch` to route is not implemented not handled properly.")
        }
    }

    func start() {
        start(animated: true)
    }

    func show(route: any Route) {
        show(route: route, withData: nil)
    }

    func `switch`(toRoute route: any Route) {
        `switch`(toRoute: route, withData: nil)
    }

    func navigateBack() {
        navigateBack(animated: true)
    }

    func navigateBack(animated: Bool) {
        if navigator.presentedViewController != nil {
            dismissPopupIfNeeded(animated: animated)
        } else {
            // Discussion: We are currently at the initial view of the flow and going back == stopping the flow:
            if let route = initialInternalRoute, navigator.topViewController?.route.matches(route) == true {
                stop()
            } else {
                _ = navigator.popViewController(animated: animated)
            }
        }
    }

    func navigateBackToRoot() {
        navigateBackToRoot(animated: true, dismissPopup: true)
    }

    func navigateBackToRoot(animated: Bool, dismissPopup: Bool) {
        guard let initialRoute = initialInternalRoute else {
            fatalError("No initial route defined.")
        }
        navigateBack(toRoute: initialRoute, animated: animated, dismissPopup: dismissPopup)
    }

    func navigateBack(toRoute route: any Route) {
        navigateBack(toRoute: route, animated: true, dismissPopup: true)
    }

    func navigateBack(toRoute route: any Route, animated: Bool, dismissPopup: Bool) {
        // Discussion: Affects only this coordinator - does not recurse to parent.
        // Use switch(toRoute:) to check also parent coordinators
        if navigator.presentedViewController?.route.matches(route) == true {
            return
        }
        if !navigator.contains(route: route) {
            return
        }

        if dismissPopup {
            dismissPopupIfNeeded(animated: animated)
        }

        // Traverse navigation stack to find a view controller matching the route.
        for viewController in navigator.viewControllers.reversed()
            where viewController.route.matches(route) {
            _ = navigator.popToViewController(viewController, animated: animated)
        }
    }

    func cleanUpNavigationStack(animated: Bool = true) {
        if let initialInternalRoute,
           let rootViewIndex = navigator.index(for: initialInternalRoute),
           rootViewIndex > 0 {
            _ = navigator.popToViewController(navigator.viewControllers[rootViewIndex - 1], animated: animated)
        } else {
            navigateBackToRoot(animated: animated, dismissPopup: true)
        }
    }
}

// MARK: - Private

private extension FlowCoordinator {
    // Discussion: If child coordinator is displayed as a popup, we want to capture it's manual dismissal (e.g. by dragging it down).
    // ... to do so, we need to subscribe to be a UIAdaptivePresentationControllerDelegate...
    // ... but a protocol cannot have default implementation of @objc methods defined in the delegate...
    // ... so we need to use this convenient wrapper and store it as an associated object.
    var popupDismissHandler: PopupDismissHandler? {
        get {
            objc_getAssociatedObject(self, &popupDismissHandlerKey) as? PopupDismissHandler
        }
        set {
            objc_setAssociatedObject(self, &popupDismissHandlerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var navigationStackChangesHandler: NavigationStackChangesHandler? {
        get {
            objc_getAssociatedObject(self, &navigationStackChangesHandlerKey) as? NavigationStackChangesHandler
        }
        set {
            objc_setAssociatedObject(self, &navigationStackChangesHandlerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var isDismissingPopup: Bool {
        get {
            objc_getAssociatedObject(self, &popupDismissInProgressKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &popupDismissInProgressKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func createAndStartInlineFlow(withData: AnyHashable?, route: any Route) {
        let flowCoordinator = makeFlowCoordinator(
            forRoute: route,
            navigator: navigator,
            withData: withData
        )
        flowCoordinator.start(animated: true)
        flowCoordinator.route = route
        flowCoordinator.completionCallback = { [weak self] in
            self?.navigator.delegate = self?.navigationStackChangesHandler
            self?.child = nil
        }
        let stackChangesHandler = NavigationStackChangesHandler { [weak self, weak flowCoordinator] route in
            // Discussion: We show route NOT supported by the flow, but supported by its parent
            // ... == we went beyond the child flow's scope.
            let parentFlowCanShow = self?.canShow(route: route) ?? false
            let childFlowCanShow = flowCoordinator?.canShow(route: route) ?? true
            if !childFlowCanShow, parentFlowCanShow {
                flowCoordinator?.stop()
            }
        }
        flowCoordinator.navigationStackChangesHandler = stackChangesHandler
        navigator.delegate = stackChangesHandler
    }

    func createAndStartFlowOnPopup(withData: AnyHashable?, route: any Route) {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = route.popupPresentationStyle.modalPresentationStyle
        let flowCoordinator = makeFlowCoordinator(
            forRoute: route,
            navigator: navigationController,
            withData: withData
        )
        flowCoordinator.start(animated: false)
        // Discussion: If there is a popup already presented, we need to dismiss it first:
        if navigator.presentedViewController != nil {
            navigator.dismiss(animated: true) { [weak self] in
                self?.navigator.present(navigationController, animated: true, completion: nil)
            }
        } else {
            navigator.present(navigationController, animated: true, completion: nil)
        }
        popupDismissHandler = PopupDismissHandler { [weak self] in
            self?.child = nil
        }
        navigationController.presentationController?.delegate = popupDismissHandler
        flowCoordinator.route = route
        flowCoordinator.completionCallback = { [weak self] in
            self?.navigateBack()
            self?.child = nil
        }
    }

    func show(viewComponent: ViewComponent, asPopup: Bool) {
        if asPopup {
            showAsPopup(viewComponent: viewComponent)
        } else {
            navigator.pushViewController(viewComponent.viewController, animated: true)
        }
    }

    func showInline(viewComponents: [ViewComponent]) {
        var currentViewControllers = navigator.viewControllers
        let viewControllers = viewComponents.map(\.viewController)
        currentViewControllers.append(contentsOf: viewControllers)
        navigator.setViewControllers(currentViewControllers, animated: true)
    }

    func showAsPopup(viewComponent: ViewComponent) {
        if navigator.presentedViewController != nil {
            navigator.dismiss(animated: true) { [weak self] in
                self?.navigator.present(viewComponent.viewController, animated: true, completion: nil)
            }
        } else {
            navigator.present(viewComponent.viewController, animated: true, completion: nil)
        }
    }

    func dismissPopupIfNeeded(animated: Bool) {
        if navigator.presentedViewController == nil {
            return
        }
        if !isDismissingPopup {
            isDismissingPopup = true
            navigator.dismiss(animated: animated) { [weak self] in
                self?.isDismissingPopup = false
            }
        }
    }

    func isShowing(route: any Route) -> Bool {
        if let popup = navigator.presentedViewController, popup.route.matches(route) {
            return true
        }

        return navigator.contains(route: route)
    }
}
