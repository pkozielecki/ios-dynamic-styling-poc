//
//  BiometricStorage.swift
//  Dynamic Styling POC
//

import AuthenticationServices
import Foundation
import KeychainAccess

public enum BiometricStorageError: Error {
    case invalidDataToStore
    case failedToStoreValue
    case failedToRetrieveValue
    case failedToDeleteItem
}

public enum BiometricStorageKey: String {
    case refreshToken
}

public protocol BiometricStorage {
    func store<T: Encodable>(value: T, at key: BiometricStorageKey) async throws
    func retrieve<T: Decodable>(itemAt key: BiometricStorageKey) async throws -> T?
    func clear(itemAt key: BiometricStorageKey) async throws
}

public final class LiveBiometricStorage: BiometricStorage {
    private let keychain: Keychain
    public init(keychain: Keychain = Keychain(service: AppConstants.biometricKeychain)) {
        self.keychain = keychain
    }

    public func store(value: some Encodable, at key: BiometricStorageKey) async throws {
        guard let data = value.data else {
            throw BiometricStorageError.invalidDataToStore
        }
        try await withCheckedThrowingContinuation { continuation in
            do {
                try keychain
                    .accessibility(.whenUnlockedThisDeviceOnly, authenticationPolicy: [.biometryAny])
                    .set(data, key: key.rawValue)
                continuation.resume()
            } catch {
                continuation.resume(throwing: BiometricStorageError.failedToStoreValue)
            }
        }
    }

    public func retrieve<T>(itemAt key: BiometricStorageKey) async throws -> T? where T: Decodable {
        try await withCheckedThrowingContinuation { continuation in
            do {
                if let data = try keychain
                    .authenticationPrompt("Authenticate to the app")
                    .getData(BiometricStorageKey.refreshToken.rawValue),
                    let value = data.decode(into: T.self) {
                    continuation.resume(returning: value)
                    return
                }
                continuation.resume(returning: nil)
            } catch {
                continuation.resume(throwing: BiometricStorageError.failedToRetrieveValue)
            }
        }
    }

    public func clear(itemAt key: BiometricStorageKey) async throws {
        try await withCheckedThrowingContinuation { continuation in
            do {
                try keychain.remove(key.rawValue)
                continuation.resume()
            } catch {
                continuation.resume(throwing: BiometricStorageError.failedToDeleteItem)
            }
        }
    }
}
