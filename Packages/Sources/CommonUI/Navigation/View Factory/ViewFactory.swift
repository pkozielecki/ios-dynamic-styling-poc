//
//  ViewFactory.swift
//  Dynamic Styling POC
//

import UIKit

public protocol ViewFactory {
    func makeView(for route: any Route) -> UIViewController?
}

extension [ViewFactory] {
    public func makeView(for route: any Route) -> UIViewController {
        for factory in self {
            if let view = factory.makeView(for: route) {
                return view
            }
        }

        fatalError("💥 [ViewFactory].makeView - Unable to make view for: \(route.name)")
    }
}
