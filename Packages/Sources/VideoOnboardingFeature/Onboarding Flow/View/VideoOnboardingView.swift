//
//  VideoOnboardingView.swift
//  Dynamic Styling POC
//

import AVKit
import Common
import CommonUI
import SwiftUI

struct VideoOnboardingView: View {
    let viewModel: VideoOnboardingViewModel
    let appStyleProvider: AppStyleProvider

    @State private var currentTab = 0

    var body: some View {
        TabView(selection: $currentTab) {
            // Slide 1:
            OnboardingView1(
                appStyleProvider: appStyleProvider,
                onSkipOnboardingPressed: {
                    currentTab = 1
                }
            )
            .tag(0)

            // Slide 3:
            OnboardingView3(
                appStyleProvider: appStyleProvider,
                onGetStartedPress: {
                    viewModel.onFinishOnboardingPressed()
                }
            )
            .tag(1)
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

private extension VideoOnboardingView {
    struct OnboardingView1: View {
        let appStyleProvider: AppStyleProvider
        let player = AVPlayer(
            // swiftlint:disable force_unwrapping
            url: Bundle.module.url(forResource: "carnivorous_plant", withExtension: "mp4")!
            // swiftlint:enable force_unwrapping
        )
        let onSkipOnboardingPressed: () -> Void

        var body: some View {
            ZStack {
                VideoPlayer(
                    player: player,
                    videoOverlay: {
                        VStack {
                            Spacer()
                            Text("Welcome to Video Onboarding!")
                                .appTextStyleFor(.title, appStyle: appStyleProvider.appStyle)
                                .multilineTextAlignment(.center)
                            Spacer()
                            Button("Skip", action: onSkipOnboardingPressed)
                                .appButtonStyleFor(.secondary, appStyle: appStyleProvider.appStyle)
                        }
                        .padding(.bottom, 65)
                        .padding(.top, 65)
                    }
                )
            }
            .onAppear {
                player.play()
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
    return VideoOnboardingView(viewModel: viewModel, appStyleProvider: PreviewFactory.makeStyleProvider())
}
#endif
