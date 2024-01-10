//
//  MainAppFlowViewFactory.swift
//  Dynamic Styling POC
//

import AppFeature
import Common
import CommonUI
import SwiftUI
import UIKit

// Discussion: This is just to demonstrate an ability to hand-craft a particular view,
// ... to be inserted into a given app Flow.
struct CustomMainAppFlowViewFactory: ViewFactory {
    func makeView(for route: any Route) -> UIViewController? {
        switch route.name {
        case MainAppRoute.welcome.name:
            Text("Override for the initial view").viewController
        default:
            nil
        }
    }
}
