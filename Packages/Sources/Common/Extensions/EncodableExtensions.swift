//
//  EncodableExtensions.swift
//  Dynamic Styling POC
//

import Foundation

public extension Encodable {
    func toDictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return json
        } catch {
            print("Error encoding to dictionary: \(error)")
            return nil
        }
    }
}
