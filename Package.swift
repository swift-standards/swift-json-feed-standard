// swift-tools-version: 6.2
import PackageDescription

extension String {
    static let jsonFeedStandard: Self = "JSON Feed Standard"
}

extension Target.Dependency {
    static var jsonFeedStandard: Self { .target(name: .jsonFeedStandard) }
    static var ieee754: Self { .product(name: "IEEE 754", package: "swift-ieee-754") }
    static var uriStandard: Self { .product(name: "URI Standard", package: "swift-uri-standard") }
    static var rfc5322: Self { .product(name: "RFC 5322", package: "swift-rfc-5322") }
}

let package = Package(
    name: "swift-json-feed-standard",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(
            name: "JSON Feed Standard",
            targets: ["JSON Feed Standard"]
        )
    ],
    dependencies: [
        .package(path: "../swift-ieee-754"),
        .package(path: "../swift-uri-standard"),
        .package(path: "../swift-rfc-5322")
    ],
    targets: [
        .target(
            name: "JSON Feed Standard",
            dependencies: [.ieee754, .uriStandard, .rfc5322]
        )
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
