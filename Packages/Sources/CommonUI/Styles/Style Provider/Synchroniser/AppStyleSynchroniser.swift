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
        do {
            let request = FetchStylesUpdateRequest()
            let response = try await networkModule.perform(request: request)
            return update(currentStyle: currentStyle, with: response.data)
        } catch {
            print("🔴 Style update download error: \(error)")
            return currentStyle
        }
    }
}

private extension LiveAppStyleSynchroniser {
    func update(currentStyle: AppStyle, with styleUpdateData: Data?) -> AppStyle {
        let currentStyleDict = currentStyle.toDictionary()
        let styleUpdateDict = try? JSONSerialization.jsonObject(with: styleUpdateData ?? Data(), options: [])
        if let currentStyleDict = currentStyleDict as? [String: AnyHashable],
           let styleUpdateDict = styleUpdateDict as? [String: AnyHashable] {
            // Discussion: The concept is really simple. Instead of merging style values menually,
            // ... let's just convert style structures to Dictionaries and merge them once:
            let mergedStyleDict = JSONMerger.mergeDictionary(currentStyleDict, with: styleUpdateDict)
            let mergedStyleData = try? JSONSerialization.data(withJSONObject: mergedStyleDict, options: [])
            // Discussion: Resulting Dictionaty will retain the structure of the original AppStyle:
            do {
                let mergedStyle = try JSONDecoder().decode(AppStyle.self, from: mergedStyleData ?? Data())
                return mergedStyle
            } catch {
                print("💥 Failed to decode merged style json: \(error)")
                return currentStyle
            }
        }
        return currentStyle
    }
}
