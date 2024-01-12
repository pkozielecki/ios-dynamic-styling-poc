//
//  AppTextFieldModifier.swift
//  Dynamic Styling POC
//

import SwiftUI

public extension TextField {
    @ViewBuilder func appTextFieldStyleFor(_ type: AppTextFieldType, appStyle: AppStyle) -> some View {
        if let style = appStyle.getTextFieldStyle(for: type) {
            textFieldStyle(style)
        }
    }
}
