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

    var body: some View {
        VStack(spacing: 10) {
            Text("Authenticate using biometry")
                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

            Spacer()

            Button("Try again") {
                Task { await viewModel.didRequestTryAgain() }
            }
            .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)

            Spacer()

            Button("Log in using email / password") {
                viewModel.didRequestSignIn()
            }
            .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
        }
        .padding()
        .task {
            await viewModel.onViewAppeared()
        }
        .navigationBarHidden(true)
    }
}

private extension BiometricAuthenticationView {
    var viewState: BiometricAuthenticationViewState {
        viewModel.viewState
    }
}
