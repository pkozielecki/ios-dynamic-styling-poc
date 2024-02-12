//
//  JsonFixtures.swift
//  Dynamic Styling POC
//

@testable import Common
import Foundation

enum JsonFixtures {
    static var empty: [String: AnyHashable] {
        [:]
    }

    static var baseJSON: [String: AnyHashable] { [
        "colors": [
            "first": [
                "lightModeValue": "#FFFF00",
                "darkModeValue": "#999900",
            ],
            "second": [
                "lightModeValue": "#FFA500",
                "darkModeValue": "#FFA500",
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
        ],
        "textField": [
            "email": [
                "textFieldShape": [
                    "rounded": [
                        "cornerRadius": 5,
                    ],
                ],
                "backgroundColor": "primary100",
                "textColor": "secondary500",
                "font": "subtitle",
                "padding": [10, 20, 10, 20],
            ] as [String: AnyHashable],
        ] as [String: AnyHashable],
    ] }

    static var updateJSON: [String: AnyHashable] { [
        "colors": [
            "first": [
                "lightModeValue": "#112233",
            ],
            "second": [
                "darkModeValue": "#aabbcc",
            ],
        ],
        "fonts": [
            "title": [
                "fontSize": 28,
            ] as [String: AnyHashable],
        ],
        "textField": [
            "email": [
                "textFieldShape": [
                    "rounded": [
                        "cornerRadius": 10,
                    ],
                ],
                "padding": [20, 20, 20, 20],
            ] as [String: AnyHashable],
        ] as [String: AnyHashable],
    ] }

    static var appendJson: [String: AnyHashable] { [
        "colors": [
            "third": [
                "lightModeValue": "#FFFF00",
                "darkModeValue": "#999900",
            ],
        ],
        "fonts": [
            "text": [
                "fontName": "Inter",
                "fontSize": 12,
                "fontWeight": "bold",
            ] as [String: AnyHashable],
        ],
        "textField": [
            "email": [
                "textFieldShape": "plain",
                "padding": [20, 20, 20, 20],
            ] as [String: AnyHashable],
        ] as [String: AnyHashable],
    ] }
}
