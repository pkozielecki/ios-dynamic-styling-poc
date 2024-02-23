//
//  CustomOnboardingView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import OnboardingFeature
import SwiftUI

struct CustomOnboardingView: View {
    let viewModel: OnboardingViewModel
    let appStyleProvider: AppStyleProvider

    @State private var currentTab = 0

    var body: some View {
        TabView(selection: $currentTab) {
            // Slide 1:
            OnboardingView1(
                appStyleProvider: appStyleProvider,
                onSkipOnboardingPressed: {
                    currentTab = 2
                }
            )
            .tag(0)

            // Slide 2:
            OnboardingView2(
                appStyleProvider: appStyleProvider
            )
            .tag(1)

            // Slide 3:
            OnboardingView3(
                appStyleProvider: appStyleProvider,
                onGetStartedPress: {
                    viewModel.onFinishOnboardingPressed()
                }
            )
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .animation(.easeIn, value: currentTab)
        .navigationBarBackButtonHidden(true)
        .task {
            viewModel.onViewAppeared()
        }
    }
}

private extension CustomOnboardingView {
    struct OnboardingView1: View {
        let appStyleProvider: AppStyleProvider
        let onSkipOnboardingPressed: () -> Void

        var body: some View {
            VStack {
                Spacer()
                Text("Welcome to Dynamic Styling showcase!")
                    .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 5)
                Text("This showcases how to inject custom views into the onboarding flow.")
                    .appTextStyleFor(.text, appStyle: appStyleProvider.appStyle)
                    .multilineTextAlignment(.center)
                Spacer()
                Button("Skip", action: onSkipOnboardingPressed)
                    .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
            }
            .padding(.bottom, 65)
            .padding(.top, 65)
        }
    }

    struct OnboardingView2: View {
        let appStyleProvider: AppStyleProvider
        var body: some View {
            VStack {
                Spacer()
                Text("👍")
                    .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)
                Text("And this is a second slide.\nHope you like it!")
                    .appTextStyleFor(.subtitle, appStyle: appStyleProvider.appStyle)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }

    struct OnboardingView3: View {
        let appStyleProvider: AppStyleProvider
        let onGetStartedPress: () -> Void

        var body: some View {
            VStack {
                Spacer()
                Text("Last screen! 🎉")
                    .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)
                Spacer()
                Button("Get Started", action: onGetStartedPress)
                    .appButtonStyleFor(.primary, appStyle: appStyleProvider.appStyle)
            }
            .padding(.bottom, 65)
            .padding(.top, 65)
        }
    }
}
