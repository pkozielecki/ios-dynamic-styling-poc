//
//  BiometricRegistrationView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct BiometricRegistrationView: View {
    let viewModel: BiometricRegistrationViewModel
    let appStyleProvider: AppStyleProvider

    var body: some View {
        VStack(spacing: 10) {
            Text("Setup biometric authentication")
                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

            Spacer()

            Image(systemName: "faceid")
                .resizable()
                .scaledToFit()
                .frame(height: 150)

            Spacer()

            Button("Register") {
                Task { await viewModel.didRequestRegisteringBiometrics() }
            }
            .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)

            Spacer()

            Button("Not now") {
                viewModel.didRequestNotNow()
            }
            .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
        }
        .padding()
        .task {
            viewModel.onViewAppeared()
        }
        .navigationBarHidden(true)
    }
}

private extension BiometricRegistrationView {
    var viewState: BiometricRegistrationViewState {
        viewModel.viewState
    }
}
