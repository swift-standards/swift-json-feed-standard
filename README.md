# swift-json-feed-standard

[![CI](https://github.com/swift-web-standards/swift-json-feed-standard/workflows/CI/badge.svg)](https://github.com/swift-web-standards/swift-json-feed-standard/actions/workflows/ci.yml)
![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Type-safe JSON Feed type definitions for Swift (Version 1.1 specification).

## Overview

swift-json-feed-standard provides complete JSON Feed 1.1 specification support with type-safe Swift types for representing JSON feed data structures.

For JSON feed generation with type-safe convenience APIs, see [swift-json-feed](https://github.com/coenttb/swift-json-feed).

## Features

- **Complete JSON Feed 1.1 Support**: All required and optional feed and item elements per JSON Feed 1.1 specification
- **Type Safety**: Compile-time validation with Hashable, Sendable, Codable conformance
- **Validation**: Throwing initializers enforce JSON Feed requirements (items require contentHTML OR contentText)
- **Swift 6.0 Concurrency**: Strict concurrency mode with complete Sendable conformance

## Installation

Add swift-json-feed-standard to your Package.swift dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/swift-web-standards/swift-json-feed-standard", from: "0.1.0")
]
```

Then add the product to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "JSONFeed Types", package: "swift-json-feed-standard")
    ]
)
```

## Quick Start

```swift
import JSONFeed

// Create a JSON feed with type-safe structures
let feed = JSONFeed.Feed(
    title: "My Blog",
    homePageURL: URL(string: "https://example.com")!,
    items: [
        try! JSONFeed.Item(
            id: "1",
            url: URL(string: "https://example.com/post1")!,
            title: "First Post",
            contentHTML: "<p>Hello, world!</p>",
            datePublished: Date()
        )
    ]
)

print(feed.title)  // "My Blog"
print(feed.items.count)  // 1
```

Note: This package provides only the type definitions. For JSON generation and parsing, see [swift-json-feed](https://github.com/coenttb/swift-json-feed).

## Related Packages

- [swift-json-feed](https://github.com/coenttb/swift-json-feed): JSON feed generation with type-safe convenience APIs and ArrayBuilder support
- [swift-rss-standard](https://github.com/swift-web-standards/swift-rss-standard): Type-safe RSS 2.0 feed type definitions
- [swift-rfc-4287](https://github.com/swift-web-standards/swift-rfc-4287): Type-safe Atom feed type definitions (RFC 4287)
- [swift-syndication](https://github.com/coenttb/swift-syndication): Unified syndication API supporting RSS, Atom, and JSON Feed with format conversion

## License

This project is licensed under the Apache License 2.0. See LICENSE for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
