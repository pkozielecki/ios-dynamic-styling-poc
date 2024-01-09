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
    func getTextFieldStyle(for textFieldType: AppTextFieldType) -> AppTextFieldStyle
    func getLabelStyle(for labelType: AppTextType) -> AppTextModifier.StyleGuide
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

    public func getLabelStyle(for labelType: AppTextType) -> AppTextModifier.StyleGuide {
        guard let style = appStyle.textStyles[labelType] else {
            fatalError("💥 AppStyleProvider.getLabelStyle - Unable to get style for: \(labelType)")
        }
        return style
    }

    public func getTextFieldStyle(for textFieldType: AppTextFieldType) -> AppTextFieldStyle {
        guard let style = appStyle.textFieldStyles[textFieldType] else {
            fatalError("💥 AppStyleProvider.getTextFieldStyle - Unable to get style for: \(textFieldType)")
        }
        return style
    }

    public func refreshStyles() {
        print("🟠 Styles refresh requested")

        // TODO: Download and merge styles.

        styleDidChangePublishSubject.send()
    }
}
