//
//  AppStyleTests.swift
//  Dynamic Styling POC
//

@testable import Common
@testable import CommonUI
import SwiftUI
@testable import TestUtils
import XCTest

final class AppStyleTests: XCTestCase {
    func test_shouldEncodeAndDecode() {
        //  given:
        let defaultStyle = AppStyle(initialDesignSystem: .preview, intialComponents: .default)

        //  when:
        let data = try? JSONEncoder().encode(defaultStyle)

        //  then:
        XCTAssertNotNil(data, "Should encode to the data object")

        //  when:
        let decodedStyle = try? JSONDecoder().decode(AppStyle.self, from: data ?? Data())

        //  then:
        XCTAssertNoDifference(defaultStyle, decodedStyle)
    }

    func test_whenDecodingStyleFromJSON_shoulProduceProperStyleObject() {
        //  given:
        let expectedStyle = AppStyle(initialDesignSystem: .preview, intialComponents: .default)

        //  when:
        let style = FileReader.readAndDecodeBundleResource(file: "mockAppStyle", extensionName: "json", decodedInto: AppStyle.self)

        //  then:
        XCTAssertNoDifference(expectedStyle, style)
    }
}
