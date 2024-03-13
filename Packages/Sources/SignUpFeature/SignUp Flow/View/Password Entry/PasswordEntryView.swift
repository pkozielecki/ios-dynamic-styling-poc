//
//  PasswordEntryView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct PasswordEntryView: View {
    let viewModel: PasswordEntryViewModel
    let appStyleProvider: AppStyleProvider
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var sendTapped: Bool = false
    @FocusState private var isEditingPassword: Bool
    @FocusState private var isConfirmingPassword: Bool

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Enter and confirm Password")
                    .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

                Spacer()

                Text("Enter a password:")
                    .appTextStyleFor(.subtitle, appStyle: appStyleProvider.appStyle)

                TextField("Password", text: $password)
                    .appTextFieldStyleFor(.password, appStyle: appStyleProvider.appStyle)
                    .focused($isEditingPassword)

                Spacer()
                    .frame(height: 30)

                Text("Confirm password:")
                    .appTextStyleFor(.subtitle, appStyle: appStyleProvider.appStyle)
                    .enabled(!password.isEmpty)

                TextField("Password confirmation", text: $passwordConfirmation)
                    .appTextFieldStyleFor(.password, appStyle: appStyleProvider.appStyle)
                    .enabled(!password.isEmpty)
                    .focused($isEditingPassword)

                Text("An error has occurred: \(error ?? "")")
                    .appTextStyleFor(.error, appStyle: appStyleProvider.appStyle)
                    .opacity(error != nil ? 1 : 0)
                    .animation(.easeIn, value: error)

                Spacer()

                Button("Send") {
                    viewModel.onPasswordRegistrationRequested(password: password)
                }
                .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
                .enabled(passwordsMatch && !sendTapped)
            }
            .animation(.easeIn, value: password)

            LoaderView(message: "Registering...", appStyleProvider: appStyleProvider)
                .opacity(isLoading ? 1 : 0)
        }
        .padding(25)
        .navigationBarHidden(true)
        .task {
            resetView()
        }
        .dismissKeyboardToolbar {
            isEditingPassword = false
            isConfirmingPassword = false
        }
        .onChange(of: viewState) { _, newState in
            if case .error = newState {
                isEditingPassword = false
                isConfirmingPassword = false
                resetView()
            }
        }
    }
}

private extension PasswordEntryView {
    var passwordsMatch: Bool {
        viewModel.passwordsMatch(password: password, passwordConfirmation: passwordConfirmation)
    }

    var viewState: PasswordEntryViewState {
        viewModel.viewState
    }

    var isLoading: Bool {
        if case .loading = viewState {
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

    func resetView() {
        password = ""
        passwordConfirmation = ""
        sendTapped = false
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewPasswordEntryViewModel()
    return PasswordEntryView(viewModel: viewModel, appStyleProvider: PreviewFactory.makeStyleProvider())
}
#endif
