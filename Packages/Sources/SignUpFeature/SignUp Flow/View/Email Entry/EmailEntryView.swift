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
                .textStyle(viewModel.appStyleProvider.getLabelStyle(for: .title))

            Spacer()

            Text("Enter an email address:")
                .textStyle(viewModel.appStyleProvider.getLabelStyle(for: .subtitle))
            TextField("Email", text: $email)
                .textFieldStyle(viewModel.appStyleProvider.getTextFieldStyle(for: .password))

            Spacer()

            Button("Send") {
                viewModel.onEmailRegistrationRequested(email: email)
            }
            .buttonStyle(viewModel.appStyleProvider.getButtonStyle(for: .primary))
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
