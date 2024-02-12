//
//  JSONMergerTests.swift
//  Dynamic Styling POC
//

@testable import Common
@testable import TestUtils
import XCTest

final class JSONMergerTests: XCTestCase {
    func test_whenMergingEmptyJson_withEmptyJSON_shouldReturnEmptyJSON() {
        //  given:
        let baseJSON = JsonFixtures.empty

        //  when:
        let mergedJSON = JSONMerger.mergeDictionary(baseJSON, with: JsonFixtures.empty)

        //  then:
        XCTAssertNoDifference(JsonFixtures.empty, mergedJSON)
    }

    func test_whenMergingSourceJSON_withEmptyJSON_shouldReturnOriginalJSON() {
        //  given:
        let baseJSON = JsonFixtures.baseJSON

        //  when:
        let mergedJSON = JSONMerger.mergeDictionary(baseJSON, with: JsonFixtures.empty)

        //  then:
        XCTAssertNoDifference(baseJSON, mergedJSON)
    }

    func test_whenMergingSourceJSON_withJsonContaingUpdates_shouldPreserveTheUpdates() {
        //  given:
        let baseJSON = JsonFixtures.baseJSON

        //  when:
        let mergedJSON = JSONMerger.mergeDictionary(baseJSON, with: JsonFixtures.updateJSON)

        //  then:
        let expectedJSON = JSONMergerTests.expectedMergedJson
        XCTAssertNoDifference(expectedJSON, mergedJSON)
    }

    func test_whenAppendingSourceJSON_withAdditionalStyles_shouldComposeUpdatedJson() {
        //  given:
        let baseJSON = JsonFixtures.baseJSON

        //  when:
        let mergedJSON = JSONMerger.mergeDictionary(baseJSON, with: JsonFixtures.appendJson)

        //  then:
        let expectedJSON = JSONMergerTests.expectedappendJson
        XCTAssertNoDifference(expectedJSON, mergedJSON)
//        XCTAssertEqual(expectedJSON, mergedJSON)
    }
}

private extension JSONMergerTests {
    static var expectedMergedJson: [String: AnyHashable] {
        [
            "colors": [
                "first": [
                    "lightModeValue": "#112233",
                    "darkModeValue": "#999900",
                ],
                "second": [
                    "lightModeValue": "#FFA500",
                    "darkModeValue": "#aabbcc",
                ],
            ],
            "fonts": [
                "title": [
                    "fontName": "Inter",
                    "fontSize": 28,
                    "fontWeight": "light",
                ] as [String: AnyHashable],
                "subtitle": [
                    "fontName": "Inter",
                    "fontSize": 14,
                    "fontWeight": "semibold",
                ],
            ],
            "textField": [
                "email": [
                    "textFieldShape": [
                        "rounded": [
                            "cornerRadius": 10,
                        ],
                    ],
                    "backgroundColor": "primary100",
                    "textColor": "secondary500",
                    "font": "subtitle",
                    "padding": [20, 20, 20, 20],
                ] as [String: AnyHashable],
            ] as [String: AnyHashable],
        ]
    }

    static var expectedappendJson: [String: AnyHashable] {
        [
            "colors": [
                "first": [
                    "lightModeValue": "#FFFF00",
                    "darkModeValue": "#999900",
                ],
                "second": [
                    "lightModeValue": "#FFA500",
                    "darkModeValue": "#FFA500",
                ],
                "third": [
                    "lightModeValue": "#FFFF00",
                    "darkModeValue": "#999900",
                ],
            ],
            "fonts": [
                "title": [
                    "fontName": "Inter",
                    "fontSize": 24,
                    "fontWeight": "light",
                ] as [String: AnyHashable],
                "subtitle": [
                    "fontName": "Inter",
                    "fontSize": 14,
                    "fontWeight": "semibold",
                ],
                "text": [
                    "fontName": "Inter",
                    "fontSize": 12,
                    "fontWeight": "bold",
                ],
            ],
            "textField": [
                "email": [
                    "textFieldShape": "plain",
                    "backgroundColor": "primary100",
                    "textColor": "secondary500",
                    "font": "subtitle",
                    "padding": [20, 20, 20, 20],
                ] as [String: AnyHashable],
            ] as [String: AnyHashable],
        ]
    }
}
