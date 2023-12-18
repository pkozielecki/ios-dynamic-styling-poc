//
//  SignInRoute.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation

enum SignInRoute: String, Route {
    case emailPasswordLogin
}

extension SignInRoute {
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
