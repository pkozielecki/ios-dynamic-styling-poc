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

            Button("Send") {
                viewModel.onEmailRegistrationRequested(email: email)
            }
            .appButtonStyleFor(.secondry, appStyle: appStyleProvider.appStyle)
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
    let appStyleProvider = LiveAppStyleProvider(initialDesignSystem: .preview)
    return EmailEntryView(viewModel: viewModel, appStyleProvider: appStyleProvider)
}
#endif
