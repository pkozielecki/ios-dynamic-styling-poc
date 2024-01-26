//
//  main.swift
//  Dynamic Styling POC
//

import UIKit

private func delegateClassName() -> String? {
    if NSClassFromString("XCTestCase") == nil {
        NSStringFromClass(AppDelegate.self)
    } else {
        NSStringFromClass(TestAppDelegate.self)
    }
}

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    delegateClassName()
)

class TestAppDelegate: UIResponder, UIApplicationDelegate {}
