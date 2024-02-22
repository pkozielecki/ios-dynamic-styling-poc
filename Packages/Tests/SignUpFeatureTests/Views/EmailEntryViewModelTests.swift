//
//  EmailEntryViewModelTests.swift
//  Dynamic Styling POC
//

@testable import SignUpFeature
import SnapshotTesting
import TestUtils
import UIKit
import XCTest

final class EmailEntryViewModelTest: XCTestCase {
    var fakeNavigationRouter: FakeNavigationRouter!
    var sut: LiveEmailEntryViewModel!

    override func setUp() {
        fakeNavigationRouter = FakeNavigationRouter()
        sut = LiveEmailEntryViewModel(router: fakeNavigationRouter)
    }

    func test_whenRequestedAuthentication_shouldNotifyRouter() {
        //  given:
        let fixtureEmail = "email@whg.com"

        //  when:
        sut.onEmailRegistrationRequested(email: fixtureEmail)

        //  then:
        let expectedRoute = SignUpRoute.passwordEntry
        let arguments = fakeNavigationRouter.showRouteAnyRouteWithDataAnyHashableIntrospectiveBoolVoidReceivedArguments
        XCTAssertEqual(fakeNavigationRouter.showRouteAnyRouteWithDataAnyHashableIntrospectiveBoolVoidCalled, true, "Should request showing route")
        XCTAssertEqual(arguments?.route.matches(expectedRoute), true, "Should show the correct route")
        XCTAssertNoDifference(arguments?.withData as? String, fixtureEmail)
    }
}