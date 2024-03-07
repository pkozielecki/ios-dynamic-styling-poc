//
//  LocalAuthenticationContextProvider.swift
//  Dynamic Styling POC
//

import Foundation
import LocalAuthentication

public protocol LocalAuthenticationContextProvider: AnyObject {
    var biometryType: LABiometryType { get }
    func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)
}

extension LAContext: LocalAuthenticationContextProvider {}
