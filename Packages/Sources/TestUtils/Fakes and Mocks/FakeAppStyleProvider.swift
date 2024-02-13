//
//  FakeAppStyleProvider.swift
//  Dynamic Styling POC
//

import CommonUI

public final class FakeAppStyleProvider: AppStyleProvider {
    public var appStyle = AppStyle(initialDesignSystem: .preview, intialComponents: .preview)

    public init() {}
    public func refreshStyles() async {}
}
