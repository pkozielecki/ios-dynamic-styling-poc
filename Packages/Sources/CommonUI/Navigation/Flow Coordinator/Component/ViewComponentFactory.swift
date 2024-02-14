//
//  ViewComponentFactory.swift
//  Dynamic Styling POC
//

import UIKit

public protocol ViewComponentFactory {
    var id: String { get }
    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent]
}

public extension [ViewComponentFactory] {
    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        for factory in self {
            let views = factory.makeViewComponents(forRoute: route, withData: data)
            if !views.isEmpty {
                return views
            }
        }
        return [ViewComponent]()
    }
}

public extension ViewComponentFactory {
    func combine(withCustomFactories factories: [any ViewComponentFactory]) -> [any ViewComponentFactory] {
        var existingFactories: [any ViewComponentFactory] = [self]
        for factory in factories where !existingFactories.contains(where: { $0.id == factory.id }) {
            existingFactories.insert(factory, at: 0)
        }
        return existingFactories
    }
}

public extension ViewComponentFactory {
    var id: String {
        String(describing: Self.self)
    }
}
