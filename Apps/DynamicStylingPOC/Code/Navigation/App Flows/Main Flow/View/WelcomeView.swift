//
//  WelcomeView.swift
//  Dynamic Styling POC
//

import SwiftUI

struct WelcomeView: View {
    let viewModel: WelcomeViewModel

    var body: some View {
        VStack(spacing: 10) {
            Text("Welcome View")
            Button("Sign Up") {
                viewModel.didRequestSignUp()
            }
            Button("Sign In") {
                viewModel.didRequestSignIn()
            }
        }
        .padding()
        .task {
            viewModel.onViewAppeared()
        }
    }
}

#Preview {
    let viewModel = PreviewWelcomeViewModel()
    return WelcomeView(viewModel: viewModel)
}
