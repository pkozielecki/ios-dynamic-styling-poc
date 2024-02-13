//
//  SignInFlowCoordinatorTests.swift
//  Dynamic Styling POC
//

@testable import Common
@testable import CommonUI
@testable import SignInFeature
import SwiftUI
@testable import TestUtils
import UIKit
import XCTest

final class SignUpFlowCoordinatorTests: XCTestCase {
    var fakeNavigator: FakeNavigator!
    var fakeNavigationRouter: FakeNavigationRouter!
    var fakeDependencyProvider: FakeDependencyProvider!
    var sut: SignInFlowCoordinator!

    override func setUp() {
        fakeNavigator = FakeNavigator()
        fakeNavigationRouter = FakeNavigationRouter()
        fakeDependencyProvider = FakeDependencyProvider(
            dependencies: [
                "NavigationRouter": fakeNavigationRouter as Any,
                "AppStyleProvider": FakeAppStyleProvider(),
            ]
        )
        sut = SignInFeatureFactory.makeSignInFlowCoordinator(
            navigator: fakeNavigator,
            parentFlow: nil,
            dependencyProvider: fakeDependencyProvider
        ) as? SignInFlowCoordinator
    }

    func test_whenStartingFlow_shouldDeployToProvidedNavigator() {
        //  given:
        let fixtureInitialRoute = SignInRoute.emailPasswordLogin

        //  when:
        sut.start(animated: true)

        //  then:
        XCTAssertEqual(fakeNavigator.lastPushedViewController?.route.matches(fixtureInitialRoute), true, "Should show initial flow route")
        XCTAssertEqual(fakeNavigator.lastPushedViewControllerAnimation, true, "Should show initial flow animated")
    }
}
