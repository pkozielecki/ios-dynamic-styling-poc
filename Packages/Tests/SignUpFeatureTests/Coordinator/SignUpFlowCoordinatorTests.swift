//
//  SignUpFlowCoordinatorTests.swift
//  Dynamic Styling POC
//

@testable import Common
@testable import CommonUI
@testable import SignUpFeature
import SwiftUI
@testable import TestUtils
import UIKit
import XCTest

final class SignUpFlowCoordinatorTests: XCTestCase {
    var fakeNavigator: FakeNavigator!
    var fakeNavigationRouter: FakeNavigationRouter!
    var fakeDependencyProvider: FakeDependencyProvider!
    var sut: SignUpFlowCoordinator!

    override func setUp() {
        fakeNavigator = FakeNavigator()
        fakeNavigationRouter = FakeNavigationRouter()
        fakeDependencyProvider = FakeDependencyProvider(
            dependencies: [
                "NavigationRouter": fakeNavigationRouter as Any,
                "AppStyleProvider": FakeAppStyleProvider(),
            ]
        )
        sut = SignUpFeatureFactory.makeSignUpFlowCoordinator(
            navigator: fakeNavigator,
            parentFlow: nil,
            dependencyProvider: fakeDependencyProvider
        ) as? SignUpFlowCoordinator
    }

    func test_whenStartingFlow_shouldDeployToProvidedNavigator() {
        //  given:
        let fixtureInitialRoute = SignUpRoute.emailEntry

        //  when:
        sut.start(animated: true)

        //  then:
        XCTAssertEqual(fakeNavigator.lastPushedViewController?.route.matches(fixtureInitialRoute), true, "Should show initial flow route")
        XCTAssertEqual(fakeNavigator.lastPushedViewControllerAnimation, true, "Should show initial flow animated")
    }

    func test_whenStoppingFlow_shouldCleanUpNavigationStack_andExecuteCallback() {
        //  given
        var didCallCallback: Bool?
        sut.start(animated: false)
        sut.show(route: SignUpRoute.passwordEntry)
        sut.completionCallback = {
            didCallCallback = true
        }

        //  when:
        sut.stop()

        //  then:
        XCTAssertEqual(fakeNavigator.lastPoppedToViewController?.route.matches(SignUpRoute.emailEntry), true, "Should pop back to root")
        XCTAssertEqual(didCallCallback, true, "Should call completion callback")
    }
}
