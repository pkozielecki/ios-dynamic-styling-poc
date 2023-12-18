//
//  ViewComponent.swift
//  Dynamic Styling POC
//

import ObjectiveC
import UIKit

private var viewComponentRouteKey: UInt8 = 123

public protocol ViewComponent: AnyObject {
    var viewController: UIViewController { get }
    var route: any Route { get set }
}

extension UIViewController: ViewComponent {
    public var viewController: UIViewController {
        self
    }

    public var route: any Route {
        get {
            objc_getAssociatedObject(self, &viewComponentRouteKey) as? any Route ?? EmptyRoute()
        }
        set {
            objc_setAssociatedObject(self, &viewComponentRouteKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
