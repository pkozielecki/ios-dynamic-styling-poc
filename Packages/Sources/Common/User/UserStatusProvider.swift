//
//  UserStatusProvider.swift
//  Dynamic Styling POC
//

import Foundation

public enum UserStatus: String, Equatable {
    case firstLaunch
    case onboardingNotFinished
    case onboardingFinished
    case authenticated
}

// sourcery: AutoMockable
public protocol UserStatusProvider: AnyObject {
    var userStatus: UserStatus { get }
}

public final class LiveUserStatusProvider: UserStatusProvider {
    private let storage: LocalStorage

    public init(storage: LocalStorage) {
        self.storage = storage
    }

    public var userStatus: UserStatus {
        let isFirstLaunch = (try? storage.getValue(forKey: StorageKeys.firstLaunch.rawValue)) ?? true
        let completedOnboarding = (try? storage.getValue(forKey: StorageKeys.completedOnboarding.rawValue)) ?? false
        let isAuthenticated: String? = try? storage.getValue(forKey: StorageKeys.authenticationToken.rawValue)

        if isFirstLaunch {
            return .firstLaunch
        } else if isAuthenticated != nil {
            return .authenticated
        } else {
            return completedOnboarding ? .onboardingFinished : .onboardingNotFinished
        }
    }
}
