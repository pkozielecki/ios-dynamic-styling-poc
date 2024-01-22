//
//  AppStyleSynchroniser.swift
//  Dynamic Styling POC
//

import Common
import Foundation

public protocol AppStyleSynchroniser: AnyObject {
    func synchroniseStyles(currentStyle: AppStyle) async -> AppStyle
}

public final class LiveAppStyleSynchroniser: AppStyleSynchroniser {
    private let networkModule: NetworkModule

    public init(networkModule: NetworkModule = resolve()) {
        self.networkModule = networkModule
    }

    @MainActor public func synchroniseStyles(currentStyle: AppStyle) async -> AppStyle {
        var newStyle = currentStyle
        let request = FetchStylesUpdateRequest()
        do {
            /*
             let response = try await networkModule.perform(request: request)
             let appStyleUpdate = try JSONDecoder().decode(AppStyleUpdate.self, from: response.data ?? Data())
             newStyle.update(with: nil, and: appStyleUpdate.designSystem)
              */
            let appStyleUpdate = try await networkModule.performAndDecode(request: request, responseType: AppStyleUpdate.self)
            newStyle.update(with: appStyleUpdate)
        } catch {
            print(error)
        }
        return newStyle
    }
}
