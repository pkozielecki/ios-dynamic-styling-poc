//
//  DynamicStylingPOCApp.swift
//  Dynamic Styling POC
//

import AppFeature
import Common
import CommonUI
import SwiftUI

@main
struct DynamicStylingPOCApp: App {

    init() {
        let initializer = DependenciesInitializer()
        initializer.registerDependencies()
    }

    var body: some Scene {
        WindowGroup {
            // TODO: Replace with proper navigation.
            AppFeatureFactory.makeAppFeature()
        }
    }
}
