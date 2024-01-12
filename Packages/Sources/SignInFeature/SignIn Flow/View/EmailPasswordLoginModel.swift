//
//  EmailPasswordLoginModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation

enum EmailPasswordLoginViewState: Equatable {
    case loading
}

protocol EmailPasswordLoginViewModel: Observable {
    var viewState: EmailPasswordLoginViewState { get }
    func onViewAppeared()
}

@Observable final class LiveEmailPasswordLoginViewModel: EmailPasswordLoginViewModel {
    private(set) var viewState: EmailPasswordLoginViewState = .loading

    private let router: NavigationRouter

    init(router: NavigationRouter) {
        self.router = router
    }

    func onViewAppeared() {}
}

private extension LiveEmailPasswordLoginViewModel {}
