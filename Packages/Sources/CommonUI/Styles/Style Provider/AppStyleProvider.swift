//
//  AppStyleProvider.swift
//  Dynamic Styling POC
//

import Combine
import SwiftUI

public protocol AppStyleProvider {
    var styleDidChange: AnyPublisher<Void, Never> { get }
    func refreshStyles()
    func getButtonStyle(for buttonType: AppButtonType) -> AppButtonStyle
}

public final class LiveAppStyleProvider {
    private var initialDesignSystem: DesignSystem
    private var appStyle: AppStyle
    private var styleDidChangePublishSubject = PassthroughSubject<Void, Never>()

    public init(initialDesignSystem: DesignSystem) {
        // Discussion: This is initial (built-in) app style.
        // ... It will be merged with the one obrained from the BE.
        self.initialDesignSystem = initialDesignSystem
        appStyle = AppStyle(initialDesignSystem: initialDesignSystem)

        // TODO: Trigger getting style update from the CMS.
    }
}

extension LiveAppStyleProvider: AppStyleProvider {
    public var styleDidChange: AnyPublisher<Void, Never> {
        styleDidChangePublishSubject.eraseToAnyPublisher()
    }

    public func getButtonStyle(for buttonType: AppButtonType) -> AppButtonStyle {
        guard let style = appStyle.buttonStyles[buttonType] else {
            fatalError("💥 AppStyleProvider.getButtonStyle - Unable to get style for: \(buttonType)")
        }
        return style
    }

    public func refreshStyles() {
        print("🟠 Styles refresh requested")

        // TODO: Download and merge styles.

        styleDidChangePublishSubject.send()
    }
}
