//
//  CustomMainAppFlowViewFactory.swift
//  Dynamic Styling POC
//

import AppFeature
import Common
import CommonUI
import SwiftUI
import UIKit

// Discussion: This is just to demonstrate an ability to hand-craft a particular view,
// ... to be inserted into a given app Flow.
struct CustomMainAppFlowViewFactory: ViewComponentFactory {
    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        switch route.name {
        case MainAppRoute.welcome.name:
            [Text("Override for the initial view").viewController]
        default:
            []
        }
    }
}