// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DynamicStylingPackages",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .singleTargetLibrary("AppFeature"),
        .singleTargetLibrary("PlaybookFeature"),
    ],
    dependencies: [
        .package(url: "https://github.com/krzysztofzablocki/Inject.git", exact: "1.2.4"),
        .package(url: "https://github.com/krzysztofzablocki/Difference.git", exact: "1.0.2"),
        .package(url: "https://github.com/playbook-ui/playbook-ios", exact: "0.3.4"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
        .package(url: "https://github.com/realm/SwiftLint", exact: "0.52.3"),
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                "CommonUI",
                "Common",
                "Inject",
                "GamesFeature",
                "AuthenticationFeature",
            ]
        ),
        .target(
            name: "GamesFeature",
            dependencies: [
                "CommonUI",
                "Common",
                "Inject",
            ]
        ),
        .target(
            name: "AuthenticationFeature",
            dependencies: [
                "CommonUI",
                "Common",
                "Inject",
            ]
        ),
        .target(
            name: "PlaybookFeature",
            dependencies: [
                "CommonUI",
                "Common",
                "Inject",
                .product(name: "Playbook", package: "playbook-ios"),
                .product(name: "PlaybookUI", package: "playbook-ios"),
            ]
        ),
        .target(
            name: "CommonUI",
            dependencies: [
                .product(name: "Inject", package: "Inject"),
            ]
        ),
        .target(
            name: "Common",
            dependencies: [
            ]
        ),
        .target(
            name: "TestUtils",
            dependencies: [
                .product(name: "Difference", package: "Difference"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: [
                "TestUtils",
            ]
        ),
        .testTarget(
            name: "CommonUITests",
            dependencies: [
                "TestUtils",
            ]
        ),
    ]
)

// Inject base plugins into each target
package.targets = package.targets.map { target in
    var plugins = target.plugins ?? []
    plugins.append(.plugin(name: "SwiftLintPlugin", package: "SwiftLint"))
    target.plugins = plugins
    return target
}

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
