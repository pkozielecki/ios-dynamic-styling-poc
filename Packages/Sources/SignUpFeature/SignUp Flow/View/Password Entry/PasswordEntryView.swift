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

            // TODO: Move to style modifier.
            TextField("Enter password", text: $password)
                .padding()
                .background(.quaternary)
                .cornerRadius(10)
                .keyboardType(.asciiCapable)

            Button("Send") {
                viewModel.onPasswordRegistrationRequested(password: password)
            }
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
