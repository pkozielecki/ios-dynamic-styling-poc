//
//  JSONParser.swift
//  Dynamic Styling POC
//

import Foundation

public enum JSONMerger {
    public static func mergeDictionary(_ base: [String: AnyHashable], with merging: [String: AnyHashable]) -> [String: AnyHashable] {
        var baseCopy = base
        for (key, value) in merging {
            // If the key is present in the base dictionary and the value is a dictionary, recursively merge
            if let baseValue = base[key],
               let baseValueDict = baseValue as? [String: AnyHashable],
               let mergingValueDict = value as? [String: AnyHashable] {
                baseCopy[key] = mergeDictionary(baseValueDict, with: mergingValueDict)
            } else {
                // Otherwise, update the value in the base dictionary
                baseCopy[key] = value
            }
        }
        return baseCopy
    }
}
