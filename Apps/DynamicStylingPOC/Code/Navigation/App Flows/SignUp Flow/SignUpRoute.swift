//
//  SignUpRoute.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation

enum SignUpRoute: String, Route {
    case emailEntry
    case passwordEntry
}

extension SignUpRoute {
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
