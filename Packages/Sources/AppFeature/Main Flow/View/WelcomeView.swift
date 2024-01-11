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
                .appTextStyleFor(.title, provider: viewModel)

            Spacer()

            Button("Sign In") {
                viewModel.didRequestSignIn()
            }
            .appButtonStyleFor(.primary, provider: viewModel)

            Spacer()

            Button("Sign Up") {
                viewModel.didRequestSignUp()
            }
            .appButtonStyleFor(.secondry, provider: viewModel)
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
