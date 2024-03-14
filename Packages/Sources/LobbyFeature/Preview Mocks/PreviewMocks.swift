//
//  PreviewMocks.swift
//  Dynamic Styling POC
//

import Combine
import Common
import CommonUI
import Foundation

#if DEBUG

final class PreviewLobbyViewModel: LobbyViewModel {
    var viewState: LobbyViewState = .registering
    func onViewAppeared() {}
}

#endif
