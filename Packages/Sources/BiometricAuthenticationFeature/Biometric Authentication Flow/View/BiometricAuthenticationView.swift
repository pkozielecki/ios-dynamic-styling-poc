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
    @State private var didTryInitialAuthentication: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Authenticate using biometry")
                    .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

                Spacer()

                if error != nil {
                    Group {
                        Text("Failed to log in: \(error ?? "")")
                            .appTextStyleFor(.error, appStyle: appStyleProvider.appStyle)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }

                Button("Try again") {
                    guard !retryTapped else { return }
                    retryTapped = true
                    Task { await viewModel.didRequestTryAgain() }
                }
                .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
                .opacity(errorOpacity)

                Spacer()

                Button("Log in using email / password") {
                    viewModel.didRequestSignIn()
                }
                .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
                .opacity(errorOpacity)
            }

            IconView(
                iconName: "checkmark.circle.fill",
                tintColor: colors.success500.color ?? .accentColor
            )
            .frame(height: 200)
            .opacity(isSuccess ? 1 : 0)
        }
        .padding()
        .task {
            if !didTryInitialAuthentication {
                didTryInitialAuthentication = true
                await viewModel.onViewAppeared()
            }
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

    var colors: AppColors {
        appStyleProvider.appStyle.designSystem.colors
    }

    var errorOpacity: Double {
        error != nil ? 1 : 0
    }
}
