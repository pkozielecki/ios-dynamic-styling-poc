//
//  AppStyleProvider.swift
//  Dynamic Styling POC
//

import Combine
import Common
import Foundation
import SwiftUI
import UIKit

public protocol AppStyleProvider: Observable {
    var appStyle: AppStyle { get }
    func refreshStyles() async
}

@Observable public final class LiveAppStyleProvider {
    private let appStyleSynchroniser: AppStyleSynchroniser
    private var initialDesignSystem: AppDesignSystem
    public private(set) var appStyle: AppStyle

    public init(appStyleSynchroniser: AppStyleSynchroniser, initialDesignSystem: AppDesignSystem) {
        // Discussion: This is initial (built-in) app style.
        // ... It will be merged with the one obrained from the BE.
        self.appStyleSynchroniser = appStyleSynchroniser
        self.initialDesignSystem = initialDesignSystem
        appStyle = AppStyle(initialDesignSystem: initialDesignSystem)
    }
}

extension LiveAppStyleProvider: AppStyleProvider {
    public func refreshStyles() async {
        print("🟠 Styles refresh requested")
        appStyle = await appStyleSynchroniser.synchroniseStyles(currentStyle: appStyle)
        print("🟢 Styles refresh finished!")
    }
}
