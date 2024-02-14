//
//  CustomMainAppFlowViewFactoryTests.swift
//  Dynamic Styling POC
//

@testable import AppFeature
@testable import DynamicStylingPOC
import SnapshotTesting
import TestUtils
import UIKit
import XCTest

final class CustomMainAppFlowViewFactoryTest: XCTestCase {
    var sut: CustomMainAppFlowViewFactory!

    override func setUp() {
        sut = CustomMainAppFlowViewFactory()
    }

    func test_whenHandlingWelcomeRoute_thenShouldCreateCustomView() {
        //  given:
        let fixtureRoute = MainAppRoute.welcome

        //  when:
        let viewController = sut.makeViewComponents(forRoute: fixtureRoute, withData: nil).first?.viewController ?? UIViewController()

        //  then:
        executeSnapshotTests(forViewController: viewController, named: "CustomMainAppFlowViewFactory-MainAppRoute.welcome")
    }
}
