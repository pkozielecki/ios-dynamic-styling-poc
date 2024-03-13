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
    var fakeLocalStorage: FakeLocalStorage!
    var fakeDependencyProvider: FakeDependencyProvider!
    var fakeInMemeoryStorage: LiveInMemoryStorage!
    var sut: SignInFlowCoordinator!

    override func setUp() {
        fakeNavigator = FakeNavigator()
        fakeNavigationRouter = FakeNavigationRouter()
        fakeLocalStorage = FakeLocalStorage()
        fakeInMemeoryStorage = LiveInMemoryStorage()
        fakeDependencyProvider = FakeDependencyProvider(
            dependencies: [
                "LocalStorage": fakeLocalStorage as Any,
                "NavigationRouter": fakeNavigationRouter as Any,
                "AppStyleProvider": FakeAppStyleProvider(),
                "InMemoryStorage": fakeInMemeoryStorage as Any,
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
