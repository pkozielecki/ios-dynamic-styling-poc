//
//  WelcomeView.swift
//  Dynamic Styling POC
//

import CommonUI
import SwiftUI
import Inject

struct WelcomeView: View {
    let viewModel: WelcomeViewModel
    let appStyleProvider: AppStyleProvider
    @ObserveInjection private var iO

    var body: some View {
        VStack(spacing: 10) {
            Text("Welcome View")
                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)

            Spacer()

            Button("Sign In") {
                viewModel.didRequestSignIn()
            }
            .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)

            Spacer()

            Button("Sign Up") {
                viewModel.didRequestSignUp()
            }
            .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
        }
        .padding()
        .onAppear {
            viewModel.onViewAppeared()
        }
        .enableInjection()
    }
}

#Preview {
    let viewModel = PreviewWelcomeViewModel()
    let appStyleProvider = PreviewFactory.makeStyleProvider()
    return WelcomeView(viewModel: viewModel, appStyleProvider: appStyleProvider)
}
