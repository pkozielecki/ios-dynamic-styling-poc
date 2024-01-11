//
//  PasswordEntryView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct PasswordEntryView: View {
    let viewModel: PasswordEntryViewModel
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 10) {
            Text("PasswordEntryView")
                .appTextStyleFor(.title, provider: viewModel)

            TextField("Enter password", text: $password)
                .appTextFieldStyleFor(.password, provider: viewModel)

            Button("Send") {
                viewModel.onPasswordRegistrationRequested(password: password)
            }
            .appButtonStyleFor(.primary, provider: viewModel)
            .disabled(password.isEmpty)
        }
        .task {
            viewModel.onViewAppeared()
        }
        .padding(25)
    }
}

private extension PasswordEntryView {
    var viewState: PasswordEntryViewState {
        viewModel.viewState
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewPasswordEntryViewModel()
    return PasswordEntryView(viewModel: viewModel)
}
#endif
