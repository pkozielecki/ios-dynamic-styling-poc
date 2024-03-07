//
//  BiometricAccessProvider.swift
//  Dynamic Styling POC
//

import LocalAuthentication

public protocol BiometricAccessProvider {
    func getSupportedBiometricsType() -> BiometricType
    func requestPermissionToAccessBiometrics(for biometryType: BiometricType) async -> Bool
}

public final class LiveBiometricAccessProvider: BiometricAccessProvider {
    let localAuthenticationContextProvider: LocalAuthenticationContextProvider

    public init(localAuthenticationContextProvider: LocalAuthenticationContextProvider = LAContext()) {
        self.localAuthenticationContextProvider = localAuthenticationContextProvider
    }

    public func getSupportedBiometricsType() -> BiometricType {
        var error: NSError?
        let isBiometryAvailable = localAuthenticationContextProvider.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        )
        if let error {
            let biometryError = LAError(_nsError: error)
            if biometryError.code == LAError.biometryNotEnrolled || biometryError.code == LAError.passcodeNotSet {
                return .notEnrolled
            } else {
                return .unavailable
            }
        } else {
            return isBiometryAvailable ? BiometricType(with: localAuthenticationContextProvider.biometryType) : .unavailable
        }
    }

    public func requestPermissionToAccessBiometrics(for biometryType: BiometricType) async -> Bool {
        guard biometryType != .unavailable, biometryType != .notEnrolled else {
            return false
        }

        return await withCheckedContinuation { continuation in
            let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
            var error: NSError?
            guard localAuthenticationContextProvider.canEvaluatePolicy(policy, error: &error) == true else {
                continuation.resume(returning: false)
                return
            }

            localAuthenticationContextProvider.evaluatePolicy(policy, localizedReason: biometryType.localizedPermissionRequestDescription) { result, _ in
                continuation.resume(returning: result)
            }
        }
    }
}
