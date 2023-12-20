//
//  MainAppRoute.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation

public enum MainAppRoute: String, Route {
    case welcome
    case signIn
    case signUp
    case authenticatedUser
}

public extension MainAppRoute {
    var name: String {
        rawValue
    }

    var isFlow: Bool {
        if case .welcome = self {
            return false
        }
        return true
    }

    var popupPresentationStyle: PopupPresentationStyle {
        .none
    }
}
