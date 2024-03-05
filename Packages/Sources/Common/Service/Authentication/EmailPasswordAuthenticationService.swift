//
//  EmailPasswordAuthenticationService.swift
//  Dynamic Styling POC
//

import Foundation

// sourcery: AutoMockable
public protocol EmailPasswordAuthenticationService: AnyObject {
    func authenticate(email: String, password: String) async throws -> Bool
}

public enum UserAuthenticationError: Error, CaseIterable {
    case invalidCredentials

    public var message: String {
        "Invalid credentials"
    }
}

public class LiveEmailPasswordAuthenticationService: EmailPasswordAuthenticationService {
    private let delayGenerator: DelayGenerator
    private let localStorage: LocalStorage

    public init(
        localStorage: LocalStorage = resolve(),
        delayGenerator: DelayGenerator = LiveDelayGenerator()
    ) {
        self.localStorage = localStorage
        self.delayGenerator = delayGenerator
    }

    public func authenticate(email: String, password: String) async throws -> Bool {
        await delayGenerator.generate(delay: .random(in: 1..<2))
        if Bool.random() {
            try localStorage.setValue("very-secure-token", forKey: StorageKeys.authenticationToken.rawValue)
            return true
        } else {
            throw UserAuthenticationError.invalidCredentials
        }
    }
}
