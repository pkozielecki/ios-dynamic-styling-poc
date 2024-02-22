//
//  EmailEntryViewTest.swift
//  Dynamic Styling POC
//

@testable import SignUpFeature
import SnapshotTesting
import TestUtils
import UIKit
import XCTest

final class EmailEntryViewTest: XCTestCase {
    var fakeEmailEntryViewModel: FakeEmailEntryViewModel!
    var fakeAppStyleProvider: FakeAppStyleProvider!
    var sut: EmailEntryView!

    override func setUp() {
        fakeEmailEntryViewModel = FakeEmailEntryViewModel()
        fakeAppStyleProvider = FakeAppStyleProvider.test
        sut = EmailEntryView(viewModel: fakeEmailEntryViewModel, appStyleProvider: fakeAppStyleProvider)
    }

    func test_whenInInitialState_shouldRenderViewProperly() {
        executeSnapshotTests(forView: sut, named: "EmailEntryView")
    }
}
