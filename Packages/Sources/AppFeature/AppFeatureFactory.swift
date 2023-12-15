//
//  AppFeatureFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI
import UIKit

public enum AppFeatureFactory {
    @ViewBuilder
    public static func makeAppFeature() -> some View {
        AppFeatureView()
    }
}
