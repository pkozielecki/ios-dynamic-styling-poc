//
//  FakeLocalStorage.swift
//  Dynamic Styling POC
//

import Common

public class FakeLocalStorage: LocalStorage {
    public var simulatedValues: [String: Any] = [:]
    public func setValue(_ value: some Encodable, forKey key: String) throws {
        simulatedValues[key] = value
    }

    public func getValue<T>(forKey key: String) throws -> T? where T: Decodable {
        simulatedValues[key] as? T
    }

    public func removeValue(forKey key: String) throws {
        simulatedValues.removeValue(forKey: key)
    }
}
