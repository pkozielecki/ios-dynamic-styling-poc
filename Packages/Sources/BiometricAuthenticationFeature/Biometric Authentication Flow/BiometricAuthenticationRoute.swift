//
//  BiometricAuthenticationRoute.swift
//  Dynamic Styling POC
//

import CommonUI

public enum BiomtricAuthenticationRoute: String, Route {
    case authentication
    case registration
}

public extension BiomtricAuthenticationRoute {
    var name: String {
        "BiomtricAuthenticationRoute.\(rawValue)"
    }

    var isFlow: Bool {
        false
    }

    var popupPresentationStyle: PopupPresentationStyle {
        .none
    }
}
