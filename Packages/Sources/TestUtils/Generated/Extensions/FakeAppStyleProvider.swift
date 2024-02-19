//
//  FakeAppStyleProvider.swift
//  Dynamic Styling POC
//

import CommonUI

public extension FakeAppStyleProvider {
    static var test: FakeAppStyleProvider {
        let provider = FakeAppStyleProvider()
        provider.underlyingAppStyle = AppStyle(initialDesignSystem: .preview, intialComponents: .preview)
        return provider
    }
}
