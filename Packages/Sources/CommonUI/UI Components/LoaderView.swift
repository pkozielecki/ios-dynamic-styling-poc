//
//  LoaderView.swift
//  Dynamic Styling POC
//

import SwiftUI

public struct LoaderView: View {
    public let message: String
    public let appStyleProvider: AppStyleProvider

    public init(message: String, appStyleProvider: AppStyleProvider) {
        self.message = message
        self.appStyleProvider = appStyleProvider
    }

    public var body: some View {
        ZStack(alignment: .center) {
            ProgressView(message)
                .tint(designSystem.colors.primary500.color)
                .scaleEffect(2)
                .font(designSystem.fonts.text.font)
                .foregroundColor(designSystem.colors.text500.color)
        }
        .frame(width: 200, height: 150)
        .background(designSystem.colors.primary900.color)
        .cornerRadius(10)
    }
}

private extension LoaderView {
    var designSystem: AppDesignSystem {
        appStyleProvider.appStyle.designSystem
    }
}

#if DEBUG
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        LoaderView(message: "Loading...", appStyleProvider: PreviewFactory.makeStyleProvider())
    }
}
#endif
