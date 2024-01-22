//
//  ViewComponentFactory.swift
//  Dynamic Styling POC
//

import UIKit

public protocol ViewComponentFactory {
    func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent]
}

extension [ViewComponentFactory] {
    public func makeViewComponents(forRoute route: any Route, withData data: AnyHashable?) -> [ViewComponent] {
        for factory in self {
            let views = factory.makeViewComponents(forRoute: route, withData: data)
            if !views.isEmpty {
                return views
            }
        }
        return [ViewComponent]()
    }
}

extension ViewComponentFactory {
    public func combine(withCustomFactory factory: ViewComponentFactory?) -> [ViewComponentFactory] {
        var factories: [ViewComponentFactory] = [self]
        if let factory {
            factories.insert(factory, at: 0)
        }
        return factories
    }
}
