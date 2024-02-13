//
//  SnapshotTestsExtensions.swift
//  Dynamic Styling POC
//

import SnapshotTesting
import SwiftUI
import UIKit

import XCTest

public extension XCTestCase {
    //  Executes a snapshot tests for a provided SwiftUI view:
    func executeSnapshotTests(
        forView view: any View,
        named name: String,
        precision: Float = 0.995,
        isRecording: Bool = false,
        file: StaticString = #file,
        functionName: String = #function,
        line: UInt = #line
    ) {
        executeSnapshotTests(
            forViewController: view.viewController,
            named: name,
            precision: precision,
            isRecording: isRecording,
            file: file,
            functionName: functionName,
            line: line
        )
    }

    //  Executes a snapshot tests for a provided UIViewController:
    func executeSnapshotTests(
        forViewController viewController: UIViewController,
        named name: String,
        precision: Float = 0.995,
        isRecording: Bool = false,
        file: StaticString = #file,
        functionName: String = #function,
        line: UInt = #line
    ) {
        viewController.loadViewIfNeeded()
        viewController.forceLightMode()
        assertSnapshot(
            matching: viewController,
            as: .image(on: .iPhone12, precision: precision, perceptualPrecision: 0.98),
            named: name,
            record: isRecording,
            file: file,
            testName: "iPhone12",
            line: line
        )
    }
}

public extension UIViewController {
    func forceLightMode() {
        overrideUserInterfaceStyle = .light
    }
}
