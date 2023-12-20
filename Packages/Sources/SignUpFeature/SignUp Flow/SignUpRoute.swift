//
//  SignUpRoute.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation

public enum SignUpRoute: String, Route {
    case emailEntry
    case passwordEntry
}

public extension SignUpRoute {
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
