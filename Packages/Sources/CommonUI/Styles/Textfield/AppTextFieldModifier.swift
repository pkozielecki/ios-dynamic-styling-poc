//
//  AppTextFieldModifier.swift
//  Dynamic Styling POC
//

import SwiftUI

public extension TextField {
    func appTextFieldStyleFor(_ type: AppTextFieldType, provider: any AppViewStyleProvider) -> some View {
        textFieldStyle(provider.getTextFieldStyle(for: type))
    }
}
