//
//  LocalStorage.swift
//  Dynamic Styling POC
//

import Foundation

public enum StorageKeys: String {
    case firstLaunch
    case completedOnboarding
    case biometricsSetUp
}

public enum StorageError: Error {
    case unableToEncodeData
    case dataStorageError
}

public protocol LocalStorage {
    func setValue<T: Encodable>(_ value: T, forKey key: String) throws
    func getValue<T: Decodable>(forKey key: String) throws -> T?
    func removeValue(forKey key: String) throws
}
