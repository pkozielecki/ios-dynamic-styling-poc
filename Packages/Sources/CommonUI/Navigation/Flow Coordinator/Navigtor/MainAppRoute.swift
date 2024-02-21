//
//  MainAppRoute.swift
//  Dynamic Styling POC
//

import Common
import Foundation

public enum MainAppRoute: String, Route {
    case splashScreen
    case onboarding
    case signIn
    case signUp
    case lobby
}

public extension MainAppRoute {
    var name: String {
        "MainAppRoute.\(rawValue)"
    }

    var isFlow: Bool {
        if case .splashScreen = self {
            return false
        }
        return true
    }

    var popupPresentationStyle: PopupPresentationStyle {
        .none
    }
}
