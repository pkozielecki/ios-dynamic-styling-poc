//
//  MainAppFlowCoordinatorTests.swift
//  Dynamic Styling POC
//

@testable import Common
@testable import CommonUI
@testable import DynamicStylingPOC
@testable import SignUpFeature
@testable import TestUtils
import SwiftUI
import UIKit
import XCTest

final class SignUpFlowCoordinatorTests: XCTestCase {
    var fakeNavigator: FakeNavigator!
    var fakeNavigationRouter: FakeNavigationRouter!
    var fakeDependencyProvider: FakeDependencyProvider!
    var fakeUserStatusProvider: FakeUserStatusProvider!
    var fakeLocalStorage: FakeLocalStorage!
    var sut: MainAppFlowCoordinator!

    override func setUp() {
        fakeNavigator = FakeNavigator()
        fakeNavigationRouter = FakeNavigationRouter()
        fakeUserStatusProvider = FakeUserStatusProvider()
        fakeLocalStorage = FakeLocalStorage()
        fakeDependencyProvider = FakeDependencyProvider(
            dependencies: [
                "NavigationRouter": fakeNavigationRouter as Any,
                "AppStyleProvider": FakeAppStyleProvider(),
                "UserStatusProvider": fakeUserStatusProvider as Any,
                "LocalStorage": fakeLocalStorage as Any,
            ]
        )
        sut = MainAppFlowCoordinator(
            navigator: fakeNavigator,
            parent: nil,
            dependencyProvider: fakeDependencyProvider
        )
    }

    func test_whenStartingFlow_shouldDeployToProvidedNavigator() {
        //  given:
        let fixtureInitialRoute = MainAppRoute.splashScreen

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
        sut.show(route: MainAppRoute.signIn)
        sut.completionCallback = {
            didCallCallback = true
        }

        //  when:
        sut.stop()

        //  then:
        XCTAssertEqual(fakeNavigator.lastPoppedToViewController?.route.matches(MainAppRoute.splashScreen), true, "Should pop back to root")
        XCTAssertEqual(didCallCallback, true, "Should call completion callback")
    }

    func test_whenStartingChildFlow_thatUsesCustomViewAndCoordinatorFactories_shouldPassTheseFactoriesToChildFlow() {
        //  given:
        sut.start(animated: false)

        //  when:
        sut.show(route: MainAppRoute.signUp)

        //  then:
        let childFlow = sut.child as? SignUpFlowCoordinator
        let viewFactories = childFlow?.viewFactories ?? []
        let coordinatorFactories = childFlow?.coordinatorFactories ?? []
        XCTAssertEqual(viewFactories.count, 2)
        XCTAssertTrue(viewFactories.contains(where: { $0.id == "MainAppFlowViewFactory" }), "Should contain Main Flow's view factory")
        XCTAssertEqual(coordinatorFactories.count, 2)
        XCTAssertTrue(coordinatorFactories.contains(where: { $0.id == "MainAppFlowCoordinatorFactory" }), "Should contain Main Flow's coord. factory")
    }
}
