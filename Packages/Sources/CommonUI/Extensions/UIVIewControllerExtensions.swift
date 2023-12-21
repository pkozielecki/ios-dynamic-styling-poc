//
//  UIVIewControllerExtensions.swift
//  Dynamic Styling POC
//

import SwiftUI
import UIKit

public extension UINavigationController {
    var swiftUIView: UINavigationControllerRepresentable {
        UINavigationControllerRepresentable(navigationController: self)
    }
}

public struct UINavigationControllerRepresentable: UIViewControllerRepresentable {
    let navigationController: UINavigationController

    public func makeUIViewController(context: Context) -> UINavigationController {
        navigationController
    }

    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
