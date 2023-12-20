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
    private var designSystem: DesignSystem
    private var styleDidChangePublishSubject = PassthroughSubject<Void, Never>()

    public init(designSystem: DesignSystem) {
        // Discussion: This is initial (built-in) app style.
        // ... It will be merged with the one obrained from the BE.
        self.designSystem = designSystem

        // TODO: Trigger getting style update from the CMS.
    }
}

extension LiveAppStyleProvider: AppStyleProvider {
    public var styleDidChange: AnyPublisher<Void, Never> {
        styleDidChangePublishSubject.eraseToAnyPublisher()
    }

    public func getButtonStyle(for buttonType: AppButtonType) -> AppButtonStyle {
        AppButtonStyle(type: buttonType, styleGuide: .init(designSystem: designSystem))
    }

    public func refreshStyles() {
        print("Styles refreshed")
        // TODO: Change styles.
        styleDidChangePublishSubject.send()
    }
}
