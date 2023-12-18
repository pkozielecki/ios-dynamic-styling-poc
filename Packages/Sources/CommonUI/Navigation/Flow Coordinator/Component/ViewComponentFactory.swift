//
//  ViewComponentFactory.swift
//  Dynamic Styling POC
//

import Foundation

public protocol ViewComponentFactory {
    func makeViewComponents(forRoute route: any Route, withData: AnyHashable?) -> [ViewComponent]
}
