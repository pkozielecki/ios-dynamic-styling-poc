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
    @State private var tapped: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            Text("Enter Email and Password")
                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

            Spacer()

            Text("Email:")
                .appTextStyleFor(.text, appStyle: appStyleProvider.appStyle)
            TextField("E.g. jane.doe[at]whg.com", text: $email)
                .appTextFieldStyleFor(.email, appStyle: appStyleProvider.appStyle)
            Text("Password:")
                .appTextStyleFor(.text, appStyle: appStyleProvider.appStyle)
            TextField("E.g. myStrongP@ssword123", text: $password)
                .appTextFieldStyleFor(.password, appStyle: appStyleProvider.appStyle)

            Spacer()
                .frame(height: 50)

            Button("Send") {
                guard !tapped else { return }
                viewModel.onLoginRequested(email: email, password: password)
                tapped = true
            }
            .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
            .disabled(email.isEmpty || tapped)

            Spacer()

            Button("Sign Up") {
                guard !tapped else { return }
                viewModel.onSignUpRequested()
                tapped = true
            }
            .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
            .disabled(tapped)
        }
        .task {
            viewModel.onViewAppeared()
        }
        .animation(.easeIn, value: email)
        .padding(25)
    }
}

private extension EmailPasswordLoginView {
    var viewState: EmailPasswordLoginViewState {
        viewModel.viewState
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewEmailPasswordLoginViewModel()
    return EmailPasswordLoginView(viewModel: viewModel, appStyleProvider: PreviewFactory.makeStyleProvider())
}
#endif
