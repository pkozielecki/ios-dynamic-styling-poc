//
//  EmailEntryView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct EmailEntryView: View {
    let viewModel: EmailEntryViewModel
    @State private var email: String = ""

    var body: some View {
        VStack(spacing: 10) {
            Text("Enter Email")
                .appTextStyleFor(.title, provider: viewModel)

            Spacer()

            Text("Enter an email address:")
                .appTextStyleFor(.subtitle, provider: viewModel)

            TextField("Email", text: $email)
                .appTextFieldStyleFor(.email, provider: viewModel)

            Spacer()

            Button("Send") {
                viewModel.onEmailRegistrationRequested(email: email)
            }
            .appButtonStyleFor(.secondry, provider: viewModel)
            .disabled(email.isEmpty)
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
    return EmailEntryView(viewModel: viewModel)
}
#endif
