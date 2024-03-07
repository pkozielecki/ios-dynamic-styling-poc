//
//  UserRegistrationService.swift
//  Dynamic Styling POC
//

import Foundation

// sourcery: AutoMockable
public protocol UserRegistrationService: AnyObject {
    func register(email: String, password: String) async throws -> String
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
    public init(
        delayGenerator: DelayGenerator = LiveDelayGenerator()
    ) {
        self.delayGenerator = delayGenerator
    }

    public func register(email: String, password: String) async throws -> String {
        await delayGenerator.generate(delay: .random(in: 1..<3))
        if Bool.random() {
            return "very-secure-token"
        } else {
            throw UserRegistrationError.invalid
        }
    }
}
