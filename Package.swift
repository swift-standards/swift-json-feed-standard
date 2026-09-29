// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-json-feed-standard",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
    ],
    products: [
        .library(
            name: "JSON Feed Standard",
            targets: ["JSON Feed Standard"]
        ),
        .library(
            name: "JSON Feed Foundation Integration",
            targets: ["JSON Feed Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-uri-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5322.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "JSON Feed Standard",
            dependencies: [
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
            ]
        ),
        .target(
            name: "JSON Feed Foundation Integration",
            dependencies: [
                .target(name: "JSON Feed Standard"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
                .product(
                    name: "RFC 3986 Foundation Integration",
                    package: "swift-rfc-3986"
                ),
                .product(
                    name: "RFC 5322 Foundation Integration",
                    package: "swift-rfc-5322"
                ),
            ]
        ),
        .testTarget(
            name: "JSON Feed Standard Tests",
            dependencies: [
                .target(name: "JSON Feed Standard"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
            ]
        ),
        .testTarget(
            name: "JSON Feed Foundation Integration Tests",
            dependencies: [
                .target(name: "JSON Feed Standard"),
                .target(name: "JSON Feed Foundation Integration"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
