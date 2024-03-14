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
    @State private var registerTapped: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            Text("Setup biometric authentication")
                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

            Spacer()

            IconView(
                iconName: "faceid",
                tintColor: tintColor ?? .clear
            )
            .frame(height: 200)
            .onTapGesture {
                print("tap")
            }

            Spacer()

            if error != nil {
                Group {
                    Text("Failed to register biometry: \(error ?? "")")
                        .appTextStyleFor(.error, appStyle: appStyleProvider.appStyle)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }

            Button("Register") {
                guard !registerTapped else { return }
                registerTapped = true
                Task { await viewModel.didRequestRegisteringBiometrics() }
            }
            .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
            .enabled(!registerTapped)
            .opacity(!isSuccess ? 1 : 0)

            Spacer()

            Button("Not now") {
                viewModel.didRequestNotNow()
            }
            .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
            .opacity(error != nil ? 1 : 0)
        }
        .padding()
        .onChange(of: viewState) { _, newState in
            if newState != .registering {
                registerTapped = false
            }
        }
        .animation(.easeIn, value: viewState)
        .navigationBarHidden(true)
    }
}

private extension BiometricRegistrationView {
    var viewState: BiometricRegistrationViewState {
        viewModel.viewState
    }

    var isSuccess: Bool {
        if case .success = viewState {
            return true
        }
        return false
    }

    var isAuthenticating: Bool {
        if case .registering = viewState {
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

    var tintColor: Color? {
        switch viewState {
        case .registering:
            colors.neutral500.color
        case .success:
            colors.success500.color
        case .error:
            colors.error500.color
        }
    }
}
