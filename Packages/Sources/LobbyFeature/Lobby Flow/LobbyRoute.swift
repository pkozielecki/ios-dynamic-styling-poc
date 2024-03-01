//
//  LobbyRoute.swift
//  Dynamic Styling POC
//

import CommonUI

public enum LobbyRoute: String, Route {
    case lobby
}

public extension LobbyRoute {
    var name: String {
        "LobbyRoute.\(rawValue)"
    }

    var isFlow: Bool {
        false
    }

    var popupPresentationStyle: PopupPresentationStyle {
        .none
    }
}
