//
//  BiometricAuthenticationView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct BiometricAuthenticationView: View {
    let viewModel: BiometricAuthenticationViewModel
    let appStyleProvider: AppStyleProvider
    @State private var retryTapped: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Authenticate using biometry")
                    .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

                Spacer()

                Group {
                    Text("An error has ocurred: \(error ?? "")")
                        .appTextStyleFor(.error, appStyle: appStyleProvider.appStyle)
                    Spacer()
                }
                .opacity(error != nil ? 1 : 0)
                .animation(.easeIn, value: error)

                Button("Try again") {
                    guard !retryTapped else { return }
                    retryTapped = true
                    Task { await viewModel.didRequestTryAgain() }
                }
                .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
                .opacity(error != nil ? 1 : 0)

                Spacer()

                Button("Log in using email / password") {
                    viewModel.didRequestSignIn()
                }
                .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
                .opacity(error != nil ? 1 : 0)
            }

            Image(systemName: "checkmark.circle.fill")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .colorMultiply(appStyleProvider.appStyle.designSystem.colors.success500.color ?? .accentColor)
                .opacity(isSuccess ? 1 : 0)
        }
        .padding()
        .task {
            await viewModel.onViewAppeared()
        }
        .onChange(of: viewState) { _, newState in
            if case .error = newState {
                retryTapped = false
            }
        }
        .animation(.easeIn, value: viewState)
        .navigationBarHidden(true)
    }
}

private extension BiometricAuthenticationView {
    var viewState: BiometricAuthenticationViewState {
        viewModel.viewState
    }

    var isSuccess: Bool {
        if case .success = viewState {
            return true
        }
        return false
    }

    var isAuthenticating: Bool {
        if case .authenticating = viewState {
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
