//
//  CustomWelcomeView.swift
//  Dynamic Styling POC
//

import CommonUI
import Inject
import OnboardingFeature
import SwiftUI

struct CustomWelcomeView: View {
    let viewModel: WelcomeViewModel
    let appStyleProvider: AppStyleProvider
    @ObserveInjection private var iO

    var body: some View {
        VStack(spacing: 10) {
            Text("Custom Welcome View")
                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)
            Text("Does it look custom enough?")
                .appTextStyleFor(.subtitle, appStyle: appStyleProvider.appStyle)

            Spacer()

            Button("Custom Sign In") {
                viewModel.didRequestSignIn()
            }
            .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)

            Spacer()

            Button("Custom Sign Up") {
                viewModel.didRequestSignUp()
            }
            .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
        }
        .padding()
        .task {
            viewModel.onViewAppeared()
        }
        .enableInjection()
        .navigationBarHidden(true)
    }
}
