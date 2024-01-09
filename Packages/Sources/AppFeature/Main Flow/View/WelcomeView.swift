//
//  WelcomeView.swift
//  Dynamic Styling POC
//

import CommonUI
import SwiftUI

struct WelcomeView: View {
    let viewModel: WelcomeViewModel

    var body: some View {
        VStack(spacing: 10) {
            Text("Welcome View")
                .textStyle(viewModel.appStyleProvider.getLabelStyle(for: .title))

            Spacer()

            Button("Sign In") {
                viewModel.didRequestSignIn()
            }
            .buttonStyle(viewModel.appStyleProvider.getButtonStyle(for: .primary))

            Spacer()

            Button("Sign Up") {
                viewModel.didRequestSignUp()
            }
            .buttonStyle(viewModel.appStyleProvider.getButtonStyle(for: .secondry))
        }
        .padding()
        .onAppear {
            viewModel.onViewAppeared()
        }
    }
}

#Preview {
    let viewModel = PreviewWelcomeViewModel()
    return WelcomeView(viewModel: viewModel)
}
