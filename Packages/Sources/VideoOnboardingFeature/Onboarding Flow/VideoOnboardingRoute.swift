//
//  VideoOnboardingRoute.swift
//  Dynamic Styling POC
//

import CommonUI

public enum VideoOnboardingRoute: String, Route {
    case onboarding
}

public extension VideoOnboardingRoute {
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
