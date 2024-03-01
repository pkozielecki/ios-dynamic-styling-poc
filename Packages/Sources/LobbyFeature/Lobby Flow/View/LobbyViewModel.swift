//
//  LobbyViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

enum LobbyViewState: Equatable {
    case loading
}

// sourcery: AutoMockable
protocol LobbyViewModel: Observable {
    var viewState: LobbyViewState { get }
    func onViewAppeared()
}

@Observable
final class LiveLobbyViewModel: LobbyViewModel {
    private(set) var viewState: LobbyViewState = .loading

    private let router: NavigationRouter

    init(router: NavigationRouter) {
        self.router = router
    }

    func onViewAppeared() {}
}

private extension LiveLobbyViewModel {}
