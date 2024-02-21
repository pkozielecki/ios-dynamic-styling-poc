//
//  OnboardingRoute.swift
//  Dynamic Styling POC
//

import CommonUI

public enum OnboardingRoute: String, Route {
    case onboarding
    case welcome
}

public extension OnboardingRoute {
    var name: String {
        "OnboardingRoute.\(rawValue)"
    }

    var isFlow: Bool {
        false
    }

    var popupPresentationStyle: PopupPresentationStyle {
        .none
    }
}
