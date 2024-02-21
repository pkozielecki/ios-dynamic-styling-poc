//
//  SplashScreenView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct SplashScreenView: View {
    let viewModel: SplashScreenViewModel
    let appStyleProvider: AppStyleProvider

    var body: some View {
        VStack {
            Text("Loading...")
                .appTextStyleFor(.text, appStyle: appStyleProvider.appStyle)
        }
        .navigationBarHidden(true)
        .task {
            viewModel.onViewAppeared()
        }
    }
}

private extension SplashScreenView {}

#if DEBUG

#Preview {
    let viewModel = PreviewSplashScreenViewModel()
    let appStyleProvider = PreviewFactory.makeStyleProvider()
    return SplashScreenView(viewModel: viewModel, appStyleProvider: appStyleProvider)
}

#endif
