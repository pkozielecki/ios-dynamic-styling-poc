//
//  CustomMainAppFlowViewFactoryTests.swift
//  Dynamic Styling POC
//

@testable import AppFeature
import CommonUI
@testable import DynamicStylingPOC
import SnapshotTesting
@testable import TestUtils
import UIKit
import XCTest

final class CustomMainAppFlowViewFactoryTest: XCTestCase {
    var sut: CustomMainAppFlowViewFactory!

    override func setUp() {
        sut = CustomMainAppFlowViewFactory()
    }

    func test_whenHandlingSplashscreenRoute_thenShouldCreateCustomView() {
        //  given:
        let fixtureRoute = MainAppRoute.splashScreen

        //  when:
        let viewController = sut.makeViewComponents(forRoute: fixtureRoute, withData: nil).first?.viewController ?? UIViewController()

        //  then:
        executeSnapshotTests(forViewController: viewController, named: "CustomMainAppFlowViewFactory-MainAppRoute.splashScreen")
    }
}
