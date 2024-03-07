//
//  EmailEntryView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct EmailEntryView: View {
    let viewModel: EmailEntryViewModel
    let appStyleProvider: AppStyleProvider
    @State private var email: String = ""
    @State private var sendTapped: Bool = false
    @State private var signInTapped: Bool = false
    @FocusState private var isEditing: Bool

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Sign Up")
                    .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

                Spacer()

                Text("Enter an email address:")
                    .appTextStyleFor(.subtitle, appStyle: appStyleProvider.appStyle)

                TextField("Email", text: $email)
                    .appTextFieldStyleFor(.email, appStyle: appStyleProvider.appStyle)
                    .focused($isEditing)

                Text("An error has occurred: \(error ?? "")")
                    .appTextStyleFor(.error, appStyle: appStyleProvider.appStyle)
                    .opacity(error != nil ? 1 : 0)
                    .animation(.easeIn, value: error)

                Spacer()
                    .frame(height: 50)

                Button("Send") {
                    guard !sendTapped else { return }
                    Task {
                        isEditing = false
                        await viewModel.onEmailRegistrationRequested(email: email)
                        sendTapped = true
                    }
                }
                .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
                .enabled(!email.isEmpty && !sendTapped)

                Spacer()

                Button("Sign In") {
                    guard !signInTapped else { return }
                    viewModel.onSignInRequested()
                    signInTapped = true
                }
                .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
                .disabled(signInTapped)
            }
            .animation(.easeIn, value: email)

            LoaderView(message: "Checking...", appStyleProvider: appStyleProvider)
                .opacity(isLoading ? 1 : 0)
        }
        .padding(25)
        .navigationBarHidden(true)
        .task {
            resetView()
            viewModel.onViewAppeared()
        }
        .dismissKeyboardToolbar {
            isEditing = false
        }
        .onChange(of: viewModel.viewState) { _, newState in
            if case .error = newState {
                isEditing = false
                sendTapped = false
            }
        }
    }
}

private extension EmailEntryView {
    var viewState: EmailEntryViewState {
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
        email = ""
        sendTapped = false
        signInTapped = false
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewEmailEntryViewModel()
    return EmailEntryView(viewModel: viewModel, appStyleProvider: PreviewFactory.makeStyleProvider())
}
#endif
