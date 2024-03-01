//
//  ViewExtensions.swift
//  Dynamic Styling POC
//

import SwiftUI
import UIKit

public extension View {
    /// Wraps a SwiftUI View into a UIViewController.
    var viewController: UIViewController {
        UIHostingController(rootView: self)
    }

    func enabled(_ isEnabled: Bool, disabledOpacity: Double = 0.3) -> some View {
        opacity(isEnabled ? 1 : disabledOpacity)
            .disabled(!isEnabled)
    }

    func dismissKeyboardToolbar(_ action: @escaping () -> Void, buttonLabel: String = "Done") -> some View {
        toolbar {
            ToolbarItem(placement: .keyboard) {
                Button(buttonLabel, action: action)
            }
        }
    }
}

public extension AnyView {
    func dismissKeyboardToolbar(_ action: @escaping () -> Void, buttonLabel: String = "Done") -> some View {
        toolbar {
            ToolbarItem(placement: .keyboard) {
                Button(buttonLabel, action: action)
            }
        }
    }
}
