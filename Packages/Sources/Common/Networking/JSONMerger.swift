//
//  JSONMerger.swift
//  Dynamic Styling POC
//

import Foundation

public enum JSONMerger {
    public static func mergeDictionary(_ base: [String: AnyHashable], with merging: [String: AnyHashable]) -> [String: AnyHashable] {
        var baseCopy = base
        for (key, value) in merging {
            // Discussion: Codable enums are encoded into a very peculiar structure, e.g.
            // enum Patron `{ case guest(String) }` can encode into: `{ "guest" : { "_0" : "John" } }`
            //
            // In order for our style merge to work, we need to detect the keys representig these enums (e.g. AppButtonShape has "shape" key)
            // ... and ensure their content replaces the original style value.
            //
            // Otherwise, if the key is present in the base dictionary and the value is a dictionary, recursively merge
            //
            // More info: https://sarunw.com/posts/codable-synthesis-for-enums-with-associated-values-in-swift/
            if let baseValue = base[key],
               let baseValueDict = baseValue as? [String: AnyHashable],
               let mergingValueDict = value as? [String: AnyHashable],
               RestrictedMergerKeys(rawValue: key) == nil {
                baseCopy[key] = mergeDictionary(baseValueDict, with: mergingValueDict)
            } else {
                // Otherwise, update the value in the base dictionary
                baseCopy[key] = value
            }
        }
        return baseCopy
    }
}

public extension JSONMerger {
    enum RestrictedMergerKeys: String {
        case buttonShape
        case textFieldShape
    }
}
