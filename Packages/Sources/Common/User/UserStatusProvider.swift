//
//  UserStatusProvider.swift
//  Dynamic Styling POC
//

import Foundation

public enum UserStatus: String, Equatable {
    case firstLaunch
    case onboardingNotFinished
    case onboardingFinished
    case biometricsSetup
    case authenticated
}

// sourcery: AutoMockable
public protocol UserStatusProvider: AnyObject {
    var userStatus: UserStatus { get }
}

public final class LiveUserStatusProvider: UserStatusProvider {
    private let storage: LocalStorage
    private let inMemoryStorage: InMemoryStorage

    public init(
        storage: LocalStorage = resolve(),
        inMemoryStorage: InMemoryStorage = resolve()
    ) {
        self.storage = storage
        self.inMemoryStorage = inMemoryStorage
    }

    public var userStatus: UserStatus {
        let isFirstLaunch: Bool? = try? storage.getValue(forKey: StorageKeys.firstLaunch.rawValue)
        let completedOnboarding: Bool? = try? storage.getValue(forKey: StorageKeys.completedOnboarding.rawValue)
        let biometricsSetup: Bool? = try? storage.getValue(forKey: StorageKeys.biometricsSetUp.rawValue)
        let refreshToken = inMemoryStorage.getValue(forKey: InMemoryStorageKey.refreshToken)

        if refreshToken != nil {
            return .authenticated
        } else if isFirstLaunch == nil {
            return .firstLaunch
        } else if biometricsSetup == true {
            return .biometricsSetup
        } else {
            return completedOnboarding == true ? .onboardingFinished : .onboardingNotFinished
        }
    }
}
