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
}
