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

    var body: some View {
        VStack(spacing: 10) {
            Text("Enter Email")
                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

            Spacer()

            Text("Enter an email address:")
                .appTextStyleFor(.subtitle, appStyle: appStyleProvider.appStyle)

            TextField("Email", text: $email)
                .appTextFieldStyleFor(.email, appStyle: appStyleProvider.appStyle)

            Spacer()
                .frame(height: 50)

            Button("Send") {
                guard !sendTapped else { return }
                viewModel.onEmailRegistrationRequested(email: email)
                sendTapped = true
            }
            .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
            .disabled(email.isEmpty || sendTapped)

            Spacer()

            Button("Sign In") {
                guard !signInTapped else { return }
                viewModel.onSignInRequested()
                signInTapped = true
            }
            .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
            .disabled(signInTapped)
        }
        .task {
            viewModel.onViewAppeared()
        }
        .animation(.easeIn, value: email)
        .padding(25)
    }
}

private extension EmailEntryView {
    var viewState: EmailEntryViewState {
        viewModel.viewState
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewEmailEntryViewModel()
    return EmailEntryView(viewModel: viewModel, appStyleProvider: PreviewFactory.makeStyleProvider())
}
#endif
