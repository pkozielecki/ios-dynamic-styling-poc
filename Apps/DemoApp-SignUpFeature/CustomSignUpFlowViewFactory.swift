//
//  CustomSignUpFlowViewFactory.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SignUpFeature
import SwiftUI
import UIKit

// Discussion: This is just to demonstrate an ability to hand-craft a particular view,
// ... to be inserted into a given app Flow.
struct CustomSignUpFlowViewFactory: ViewComponentFactory {
    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        switch route.name {
        case SignUpRoute.emailEntry.name:
            [Text("Override for the initial view").viewController]
        default:
            []
        }
    }
}
