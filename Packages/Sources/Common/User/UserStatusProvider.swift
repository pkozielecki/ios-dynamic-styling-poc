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

    public init(storage: LocalStorage = resolve()) {
        self.storage = storage
    }

    public var userStatus: UserStatus {
        let isFirstLaunch: Bool? = try? storage.getValue(forKey: StorageKeys.firstLaunch.rawValue)
        let completedOnboarding: Bool? = try? storage.getValue(forKey: StorageKeys.completedOnboarding.rawValue)
        let authenticationToken: String? = try? storage.getValue(forKey: StorageKeys.authenticationToken.rawValue)

        if isFirstLaunch == nil {
            return .firstLaunch
        } else if authenticationToken != nil {
            return .authenticated
        } else {
            return completedOnboarding == true ? .onboardingFinished : .onboardingNotFinished
        }
    }
}
