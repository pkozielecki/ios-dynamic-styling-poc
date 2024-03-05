//
//  UserRegistrationService.swift
//  Dynamic Styling POC
//

import Foundation

// sourcery: AutoMockable
public protocol UserRegistrationService: AnyObject {
    func register(email: String, password: String) async throws -> Bool
}

public enum UserRegistrationError: Error, CaseIterable {
    case invalid
    case failed

    public var message: String {
        switch self {
        case .invalid: "Password is invalid."
        case .failed: "Failed to regster a password."
        }
    }
}

public class LiveUserRegistrationService: UserRegistrationService {
    private let delayGenerator: DelayGenerator
    private let localStorage: LocalStorage

    public init(
        localStorage: LocalStorage = resolve(),
        delayGenerator: DelayGenerator = LiveDelayGenerator()
    ) {
        self.localStorage = localStorage
        self.delayGenerator = delayGenerator
    }

    public func register(email: String, password: String) async throws -> Bool {
        await delayGenerator.generate(delay: .random(in: 1..<3))
        if Bool.random() {
            try localStorage.setValue("very-secure-token", forKey: StorageKeys.authenticationToken.rawValue)
            return true
        } else {
            throw UserRegistrationError.invalid
        }
    }
}
