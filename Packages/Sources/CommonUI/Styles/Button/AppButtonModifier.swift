//
//  AppButtonModifier.swift
//  Dynamic Styling POC
//

import SwiftUI

public extension Button {
    func appButtonStyleFor(_ buttonType: AppButtonType, provider: any AppViewStyleProvider) -> some View {
        buttonStyle(provider.getButtonStyle(for: buttonType))
    }
}
