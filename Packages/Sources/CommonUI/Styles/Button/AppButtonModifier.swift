//
//  AppButtonModifier.swift
//  Dynamic Styling POC
//

import SwiftUI

public extension Button {
    @ViewBuilder func appButtonStyleFor(_ buttonType: AppButtonType, appStyle: AppStyle) -> some View {
        if let style = appStyle.getButtonStyle(for: buttonType) {
            buttonStyle(style)
        }
    }
}
