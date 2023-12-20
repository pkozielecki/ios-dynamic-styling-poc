//
//  SignInRoute.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation

public enum SignInRoute: String, Route {
    case emailPasswordLogin
}

public extension SignInRoute {
    var name: String {
        rawValue
    }

    var isFlow: Bool {
        false
    }

    var popupPresentationStyle: PopupPresentationStyle {
        .none
    }
}
