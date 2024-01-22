//
//  PasswordEntryView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct PasswordEntryView: View {
    let viewModel: PasswordEntryViewModel
    let appStyleProvider: AppStyleProvider
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 10) {
            Text("PasswordEntryView")
                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

            TextField("Enter password", text: $password)
                .appTextFieldStyleFor(.password, appStyle: appStyleProvider.appStyle)

            Button("Send") {
                viewModel.onPasswordRegistrationRequested(password: password)
            }
            .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
            .disabled(password.isEmpty)
        }
        .task {
            viewModel.onViewAppeared()
        }
        .padding(25)
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewPasswordEntryViewModel()
    let appStyleProvider = PreviewFactory.makeStyleProvider()
    return PasswordEntryView(viewModel: viewModel, appStyleProvider: appStyleProvider)
}
#endif
