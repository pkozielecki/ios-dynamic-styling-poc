//
//  EmailPasswordLoginView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct EmailPasswordLoginView: View {
    let viewModel: EmailPasswordLoginViewModel
    let appStyleProvider: AppStyleProvider
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var sendTapped: Bool = false
    @State private var signUpTapped: Bool = false
    @FocusState private var isEditingEmail: Bool
    @FocusState private var isEditingPassword: Bool

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Sign In")
                    .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

                Spacer()

                Text("Enter an email:")
                    .appTextStyleFor(.text, appStyle: appStyleProvider.appStyle)
                TextField("E.g. jane.doe[at]whg.com", text: $email)
                    .appTextFieldStyleFor(.email, appStyle: appStyleProvider.appStyle)
                    .focused($isEditingEmail)

                Spacer()
                    .frame(height: 30)

                Text("Enter password:")
                    .appTextStyleFor(.text, appStyle: appStyleProvider.appStyle)
                TextField("E.g. myStrongP@ssword123", text: $password)
                    .appTextFieldStyleFor(.password, appStyle: appStyleProvider.appStyle)
                    .focused($isEditingPassword)
                Text("An error has occurred: \(error ?? "")")
                    .appTextStyleFor(.error, appStyle: appStyleProvider.appStyle)
                    .opacity(error != nil ? 1 : 0)
                    .animation(.easeIn, value: error)

                Spacer()
                    .frame(height: 50)

                Button("Send") {
                    guard !sendTapped else { return }
                    viewModel.onLoginRequested(email: email, password: password)
                    sendTapped = true
                }
                .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
                .enabled(!email.isEmpty && !password.isEmpty && !sendTapped)

                Spacer()

                Button("Sign Up") {
                    guard !signUpTapped else { return }
                    viewModel.onSignUpRequested()
                    signUpTapped = true
                }
                .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
                .enabled(!signUpTapped)
            }

            LoaderView(message: "Logging in...", appStyleProvider: appStyleProvider)
                .opacity(isLoading ? 1 : 0)
        }
        .task {
            viewModel.onViewAppeared()
        }
        .animation(.easeIn, value: viewState)
        .dismissKeyboardToolbar {
            isEditingEmail = false
            isEditingPassword = false
        }
        .onChange(of: viewState) { _, newState in
            if case .error = newState {
                isEditingEmail = false
                isEditingPassword = false
                resetView()
            }
        }
        .padding(25)
    }
}

private extension EmailPasswordLoginView {
    var viewState: EmailPasswordLoginViewState {
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
        sendTapped = false
        signUpTapped = false
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewEmailPasswordLoginViewModel()
    return EmailPasswordLoginView(viewModel: viewModel, appStyleProvider: PreviewFactory.makeStyleProvider())
}
#endif
