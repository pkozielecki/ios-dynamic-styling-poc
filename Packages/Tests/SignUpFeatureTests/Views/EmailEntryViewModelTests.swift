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
    var fakeEmailAvailabilityChecker: FakeEmailAvailabilityChecker!
    var sut: LiveEmailEntryViewModel!

    override func setUp() {
        fakeNavigationRouter = FakeNavigationRouter()
        fakeEmailAvailabilityChecker = FakeEmailAvailabilityChecker()
        sut = LiveEmailEntryViewModel(router: fakeNavigationRouter, availabilityChecker: fakeEmailAvailabilityChecker)
    }

    func test_whenRequestedAuthentication_shouldNotifyRouter() async {
        //  given:
        let fixtureEmail = "email@whg.com"
        fakeEmailAvailabilityChecker.checkEmailStringBoolReturnValue = true

        //  when:
        await sut.onEmailRegistrationRequested(email: fixtureEmail)

        //  then:
        let email = fakeEmailAvailabilityChecker.checkEmailStringBoolReceivedEmail
        XCTAssertNoDifference(fixtureEmail, email)

        // TODO: Cover the rest of the flow.
    }
}
