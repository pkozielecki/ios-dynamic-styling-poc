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
        .singleTargetLibrary("SignInFeature"),
        .singleTargetLibrary("SignUpFeature"),
        .singleTargetLibrary("PlaybookFeature"),
    ],
    dependencies: [
        .package(url: "https://github.com/krzysztofzablocki/Inject.git", exact: "1.2.4"),
        .package(url: "https://github.com/krzysztofzablocki/Difference.git", exact: "1.0.2"),
        .package(url: "https://github.com/playbook-ui/playbook-ios", exact: "0.3.4"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
        .package(url: "https://github.com/realm/SwiftLint", exact: "0.52.3"),
        .package(url: "https://github.com/netguru/ng-ios-network-module", from: "1.0.4"),
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: Dependencies.common + [
                "GamesFeature",
                "SignInFeature",
                "SignUpFeature",
            ]
        ),
        .target(
            name: "PlaybookFeature",
            dependencies: Dependencies.common + [
                "GamesFeature",
                "AppFeature",
                "SignInFeature",
                "SignUpFeature",
                .product(name: "Playbook", package: "playbook-ios"),
                .product(name: "PlaybookUI", package: "playbook-ios"),
            ]
        ),
        .target(
            name: "GamesFeature",
            dependencies: Dependencies.common
        ),
        .target(
            name: "SignInFeature",
            dependencies: Dependencies.common
        ),
        .target(
            name: "SignUpFeature",
            dependencies: Dependencies.common
        ),
        .target(
            name: "CommonUI",
            dependencies: [
                .product(name: "Inject", package: "Inject"),
                "Common",
            ],
            resources: [
                .process("Resources"),
            ],
            swiftSettings: [.define("ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS")]
        ),
        .target(
            name: "Common",
            dependencies: [
                .product(name: "NgNetworkModuleCore", package: "ng-ios-network-module"),
                .product(name: "ConcurrentNgNetworkModule", package: "ng-ios-network-module"),
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
                "Common",
            ]
        ),
        .testTarget(
            name: "CommonUITests",
            dependencies: [
                "TestUtils",
                "CommonUI",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)

enum Dependencies {
    static var common: [Target.Dependency] {
        [
            "CommonUI",
            "Common",
            "Inject",
        ]
    }
}

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
