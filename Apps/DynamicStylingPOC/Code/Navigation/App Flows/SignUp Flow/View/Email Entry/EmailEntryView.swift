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
            Text("EmailEntryView")

            // TODO: Move to style modifier.
            TextField("Enter email", text: $email)
                .padding()
                .background(.quaternary)
                .cornerRadius(10)
                .keyboardType(.emailAddress)

            Button("Send") {
                viewModel.onEmailRegistrationRequested(email: email)
            }
            .disabled(email.isEmpty)
        }
        .task {
            viewModel.onViewAppeared()
        }
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
