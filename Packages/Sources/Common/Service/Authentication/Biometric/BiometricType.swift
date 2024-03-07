//
//  BiometricType.swift
//  Dynamic Styling POC
//

import Foundation
import LocalAuthentication

public enum BiometricType: String, Equatable {
    case touchID
    case faceID
    case unavailable
    case notEnrolled
}

public extension BiometricType {
    init(with localAuthenticationType: LABiometryType) {
        switch localAuthenticationType {
        case .none, .opticID:
            self = .unavailable
        case .faceID:
            self = .faceID
        case .touchID:
            self = .touchID
        @unknown default:
            self = .unavailable
        }
    }

    var isBiometryEnabled: Bool {
        switch self {
        case .faceID, .touchID:
            true
        case .notEnrolled, .unavailable:
            false
        }
    }

    var localizedPermissionRequestDescription: String {
        switch self {
        case .faceID:
            "Authenticate with Face ID"
        case .touchID:
            "Authenticate with Touch ID"
        case .unavailable, .notEnrolled:
            ""
        }
    }
}
