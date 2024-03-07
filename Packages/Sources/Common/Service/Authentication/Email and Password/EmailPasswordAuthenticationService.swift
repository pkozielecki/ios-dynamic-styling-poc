//
//  EmailPasswordAuthenticationService.swift
//  Dynamic Styling POC
//

import Foundation

// sourcery: AutoMockable
public protocol EmailPasswordAuthenticationService: AnyObject {
    func authenticate(email: String, password: String) async throws -> String
}

public enum UserAuthenticationError: Error, CaseIterable {
    case invalidCredentials

    public var message: String {
        "Invalid credentials"
    }
}

public class LiveEmailPasswordAuthenticationService: EmailPasswordAuthenticationService {
    private let delayGenerator: DelayGenerator

    public init(
        delayGenerator: DelayGenerator = LiveDelayGenerator()
    ) {
        self.delayGenerator = delayGenerator
    }

    public func authenticate(email: String, password: String) async throws -> String {
        await delayGenerator.generate(delay: .random(in: 1..<2))
        if Bool.random() {
            return "very-secure-token"
        } else {
            throw UserAuthenticationError.invalidCredentials
        }
    }
}
