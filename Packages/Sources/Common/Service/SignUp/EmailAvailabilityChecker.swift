//
//  EmailAvailabilityChecker.swift
//  Dynamic Styling POC
//

import ConcurrentNgNetworkModule
import Foundation
import NgNetworkModuleCore

// sourcery: AutoMockable
public protocol EmailAvailabilityChecker: AnyObject {
    func check(email: String) async throws -> Bool
}

public enum EmailAvailabilityCheckError: Error, CaseIterable {
    case alreadyExists
    case invalid

    public var message: String {
        switch self {
        case .alreadyExists: "Email address already exists."
        case .invalid: "Email address is invalid."
        }
    }
}

public class LiveEmailRegistrationService: EmailAvailabilityChecker {
    private let delayGenerator: DelayGenerator

    public init(delayGenerator: DelayGenerator = LiveDelayGenerator()) {
        self.delayGenerator = delayGenerator
    }

    public func check(email: String) async throws -> Bool {
        await delayGenerator.generate(delay: .random(in: 1..<2))
        if Bool.random() {
            return true
        } else {
            throw EmailAvailabilityCheckError.allCases.randomElement() ?? .alreadyExists
        }
    }
}
