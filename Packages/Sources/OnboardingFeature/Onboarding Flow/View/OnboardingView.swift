//
//  OnboardingView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct OnboardingView: View {
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

private extension OnboardingView {
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
                Button("Skip", action: onSkipOnboardingPressed)
                    .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
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
                Text("Shake your device to download style updates from server.")
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

#if DEBUG
#Preview {
    let viewModel = PreviewOnboardingViewModel()
    let appStyleProvider = PreviewFactory.makeStyleProvider()
    return OnboardingView(viewModel: viewModel, appStyleProvider: appStyleProvider)
}
#endif
