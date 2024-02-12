//
//  DifferenceExports.swift
//  Dynamic Styling POC
//

@_exported import Difference // Discussion: To avoid importing testing essential across the app.

import XCTest

public extension XCTestCase {
    func XCTAssertNoDifference<T: Equatable>(_ expected: @autoclosure () throws -> T, _ received: @autoclosure () throws -> T, file: StaticString = #filePath, line: UInt = #line) {
        do {
            let expected = try expected()
            let received = try received()
            XCTAssertTrue(expected == received, "Found difference for \n" + diff(expected, received).joined(separator: ", "), file: file, line: line)
        } catch {
            XCTFail("Caught error while testing: \(error)", file: file, line: line)
        }
    }
}
