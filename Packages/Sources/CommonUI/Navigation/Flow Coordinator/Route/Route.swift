//
//  Route.swift
//  Dynamic Styling POC
//

import UIKit

public enum PopupPresentationStyle: Equatable {
    case none
    case fullScreen
    case modal
}

public extension PopupPresentationStyle {
    var modalPresentationStyle: UIModalPresentationStyle {
        switch self {
        case .none:
            .none
        case .fullScreen:
            .fullScreen
        case .modal:
            .pageSheet
        }
    }
}

public protocol Route: Equatable {
    var name: String { get }
    var isFlow: Bool { get }
    var popupPresentationStyle: PopupPresentationStyle { get }
}

public extension Route {
    var isPopup: Bool {
        switch popupPresentationStyle {
        case .none:
            false
        case .fullScreen, .modal:
            true
        }
    }

    func matches(_ route: any Route) -> Bool {
        name == route.name && isFlow == route.isFlow && popupPresentationStyle == route.popupPresentationStyle
    }
}

public struct EmptyRoute: Route {
    public init() {}

    public var name: String {
        ""
    }

    public var isFlow: Bool {
        false
    }

    public var popupPresentationStyle: PopupPresentationStyle {
        .none
    }
}
