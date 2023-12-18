//
//  EmailEntryViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

enum EmailEntryViewState: Equatable {
    case loading
}

protocol EmailEntryViewModel: Observable {
    var viewState: EmailEntryViewState { get }
    func onViewAppeared()
}

@Observable
final class LiveEmailEntryViewModel: EmailEntryViewModel {
    private(set) var viewState: EmailEntryViewState = .loading

    private let router: NavigationRouter

    init(router: NavigationRouter) {
        self.router = router
    }

    func onViewAppeared() {}
}

private extension LiveEmailEntryViewModel {}
