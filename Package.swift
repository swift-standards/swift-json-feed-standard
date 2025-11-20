// swift-tools-version: 6.2
import PackageDescription

extension String {
    static let jsonFeedStandard: Self = "JSON Feed Standard"
}

extension Target.Dependency {
    static var jsonFeedStandard: Self { .target(name: .jsonFeedStandard) }
    static var uriStandard: Self { .product(name: "URI Standard", package: "swift-uri-standard") }
    static var rfc5322: Self { .product(name: "RFC 5322", package: "swift-rfc-5322") }
}

let package = Package(
    name: "swift-json-feed-standard",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11)
    ],
    products: [
        .library(
            name: .jsonFeedStandard,
            targets: [.jsonFeedStandard]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-uri-standard", from: "0.1.0"),
        .package(url: "https://github.com/swift-standards/swift-rfc-5322", from: "0.1.0")
    ],
    targets: [
        .target(
            name: .jsonFeedStandard,
            dependencies: [.uriStandard, .rfc5322],
            swiftSettings: [
                .swiftLanguageMode(.v6),
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: .jsonFeedStandard.tests,
            dependencies: [.jsonFeedStandard],
            swiftSettings: [
                .swiftLanguageMode(.v6),
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
    var foundation: Self { self + " Foundation" }
}

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings = existing + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility")
    ]
}
