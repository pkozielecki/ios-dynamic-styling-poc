//
//  InMemoryStorage.swift
//  Dynamic Styling POC
//

import Foundation

public enum InMemoryStorageKey: String {
    case refreshToken
}

public protocol InMemoryStorage: AnyObject {
    func setValue(_ value: Any, forKey key: InMemoryStorageKey)
    func getValue(forKey key: InMemoryStorageKey) -> Any?
    func removeValue(forKey key: InMemoryStorageKey)
}

public final class LiveInMemoryStorage: InMemoryStorage {
    private var storage: [String: Any]

    public init() {
        storage = [String: Any]()
    }

    public func setValue(_ value: Any, forKey key: InMemoryStorageKey) {
        storage[key.rawValue] = value
    }

    public func getValue(forKey key: InMemoryStorageKey) -> Any? {
        storage[key.rawValue]
    }

    public func removeValue(forKey key: InMemoryStorageKey) {
        storage[key.rawValue] = nil
    }
}
