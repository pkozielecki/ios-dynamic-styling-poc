//
//  LobbyViewModel.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Foundation
import Observation
import UIKit

enum LobbyViewState: Equatable {
    case loggingOut
    case idle
    case error(message: String)
}

// sourcery: AutoMockable
protocol LobbyViewModel: Observable {
    var viewState: LobbyViewState { get }
    func didRequestLogOut() async
}

@Observable
final class LiveLobbyViewModel: LobbyViewModel {
    private(set) var viewState: LobbyViewState = .idle

    private let router: NavigationRouter
    private let biometricStorage: BiometricStorage
    private let inMemoryStorage: InMemoryStorage
    private let alertPresenter: AlertPresenter

    init(
        router: NavigationRouter,
        biometricStorage: BiometricStorage,
        inMemoryStorage: InMemoryStorage,
        alertPresenter: AlertPresenter = LiveAlertPresenter()
    ) {
        self.router = router
        self.biometricStorage = biometricStorage
        self.inMemoryStorage = inMemoryStorage
        self.alertPresenter = alertPresenter
    }

    @MainActor func didRequestLogOut() async {
        guard let visibleVC = router.currentFlow?.navigator.visibleViewController else {
            return
        }
        showLogoutAlert(on: visibleVC)
    }
}

private extension LiveLobbyViewModel {
    func showLogoutAlert(on visibleVC: UIViewController) {
        alertPresenter.showAcceptanceAlert(
            on: visibleVC,
            title: "Confirmation",
            message: "Would you like to log out?",
            yesActionTitle: "yes",
            noActionTitle: "no",
            yesActionStyle: .destructive,
            noActionStyle: .cancel
        ) { [weak self] action in
            switch action {
            case .yes:
                self?.logUserOut()
            case .no:
                self?.viewState = .idle
            }
        }
    }

    func logUserOut() {
        Task { @MainActor in
            do {
                try await biometricStorage.clear(itemAt: .refreshToken)
                inMemoryStorage.removeValue(forKey: .refreshToken)
                viewState = .idle
                router.show(route: MainAppRoute.signIn, withData: nil, introspective: true)
            } catch {
                viewState = .error(message: "An error has ocurred: \(error)")
            }
        }
    }
}
