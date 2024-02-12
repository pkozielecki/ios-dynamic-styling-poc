//
//  FakeAppStyleProvider.swift
//  Dynamic Styling POC
//

import CommonUI

final class FakeAppStyleProvider: AppStyleProvider {
    var appStyle = AppStyle(initialDesignSystem: .preview, intialComponents: .preview)

    public init() {}

    public func refreshStyles() async {}
}
