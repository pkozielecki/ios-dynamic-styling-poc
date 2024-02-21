//
//  UserDefaultsStorage.swift
//  Dynamic Styling POC
//

import Foundation

extension UserDefaults: LocalStorage {
    public func setValue(_ value: some Encodable, forKey key: String) throws {
        guard let encoded = try? JSONEncoder().encode(value) else {
            throw StorageError.unableToEncodeData
        }
        set(encoded, forKey: key)
    }

    public func getValue<T: Decodable>(forKey key: String) throws -> T? {
        guard let data = data(forKey: key) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    public func removeValue(forKey key: String) throws {
        removeObject(forKey: key)
    }
}
