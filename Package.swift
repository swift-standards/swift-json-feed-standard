// swift-tools-version: 6.0
import PackageDescription

extension String {
    static let jsonFeedStandard: Self = "JSON Feed Standard"
}

extension Target.Dependency {
    static var jsonFeedStandard: Self { .target(name: .jsonFeedStandard) }
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
    targets: [
        .target(
            name: .jsonFeedStandard,
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
    ]
)

extension String { var tests: Self { self + " Tests" } }
