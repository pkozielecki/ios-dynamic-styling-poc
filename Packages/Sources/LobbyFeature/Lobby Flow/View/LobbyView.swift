//
//  LobbyView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import Inject
import SwiftUI

struct LobbyView: View {
    let viewModel: LobbyViewModel
    let appStyleProvider: AppStyleProvider
    @ObserveInjection private var iO

    var body: some View {
        VStack {
            Text("Lobby View")
                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)
        }
        .task {
            viewModel.onViewAppeared()
        }
        .enableInjection()
    }
}

private extension LobbyView {
    var viewState: LobbyViewState {
        viewModel.viewState
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewLobbyViewModel()
    return LobbyView(viewModel: viewModel, appStyleProvider: PreviewFactory.makeStyleProvider())
}
#endif
