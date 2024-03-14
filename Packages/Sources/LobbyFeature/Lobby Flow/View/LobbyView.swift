//
//  LobbyView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct LobbyView: View {
    let viewModel: LobbyViewModel
    let appStyleProvider: AppStyleProvider

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Lobby View")
                    .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

                Text("Select a game to play")
                    .appTextStyleFor(.subtitle, appStyle: appStyleProvider.appStyle)

                Spacer()

                Text("TODO: Add games categories, tiles, etc.")
                    .appTextStyleFor(.text, appStyle: appStyleProvider.appStyle)

                if error != nil, !isLoggingOut {
                    Group {
                        Text("Failed to log out: \(error ?? "")")
                            .appTextStyleFor(.error, appStyle: appStyleProvider.appStyle)
                            .multilineTextAlignment(.center)
                    }
                }

                Spacer()

                Button("Log out") {
                    Task {
                        await viewModel.didRequestLogOut()
                    }
                }
                .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
            }
            .blur(radius: isLoggingOut ? 10 : 0)

            LoaderView(message: "logging out", appStyleProvider: appStyleProvider)
                .opacity(isLoggingOut ? 1 : 0)
        }
        .padding(10)
        .animation(.easeIn, value: viewState)
    }
}

private extension LobbyView {
    var viewState: LobbyViewState {
        viewModel.viewState
    }

    var isLoggingOut: Bool {
        if case .loggingOut = viewState {
            return true
        }
        return false
    }

    var error: String? {
        if case let .error(message) = viewState {
            return message
        }
        return nil
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewLobbyViewModel()
    return LobbyView(viewModel: viewModel, appStyleProvider: PreviewFactory.makeStyleProvider())
}
#endif
