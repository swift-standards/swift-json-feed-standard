# swift-json-feed-standard

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-standards/swift-json-feed-standard/workflows/CI/badge.svg)](https://github.com/swift-standards/swift-json-feed-standard/actions/workflows/ci.yml)

Type-safe JSON Feed 1.1 type definitions for Swift.

## Overview

swift-json-feed-standard is a pure domain model of the JSON Feed 1.1 specification: `JSONFeed.Feed`, `JSONFeed.Item`, `JSONFeed.Author`, `JSONFeed.Hub` and `JSONFeed.Attachment`, with `RFC_3986.URI` for every URL element and `RFC_5322.Date` for every date element.

Apple Foundation bridging — the `Codable` conformances that read and write JSON Feed documents with their specified member names — lives in the separate `JSON Feed Foundation Integration` product.

## Products

- `JSON Feed Standard` (module `JSON_Feed_Standard`): the domain model.
- `JSON Feed Foundation Integration` (module `JSON_Feed_Foundation_Integration`): `Encodable`/`Decodable` conformances for the domain types.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-standards/swift-json-feed-standard", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "JSON Feed Standard", package: "swift-json-feed-standard"),
        .product(name: "JSON Feed Foundation Integration", package: "swift-json-feed-standard"),
    ]
)
```

## Quick Start

```swift
import JSON_Feed_Standard
import RFC_5322
import URI_Standard

let feed = JSONFeed.Feed(
    title: "My Blog",
    homePageURL: try URI("https://example.com"),
    items: [
        try JSONFeed.Item(
            id: "1",
            url: try URI("https://example.com/post1"),
            title: "First Post",
            contentHTML: "<p>Hello, world!</p>",
            datePublished: try RFC_5322.Date(year: 2025, month: 1, day: 1)
        )
    ]
)

feed.version  // "https://jsonfeed.org/version/1.1"
feed.items.count  // 1
```

An item must carry `contentHTML` or `contentText`; the initializer throws `JSONFeed.Error.itemRequiresContent` otherwise.

## Reading and writing documents

```swift
import Foundation
import JSON_Feed_Foundation_Integration
import JSON_Feed_Standard

let document = try JSONEncoder().encode(feed)
let decoded = try JSONDecoder().decode(JSONFeed.Feed.self, from: document)
```

## Related Packages

- [swift-rss-standard](https://github.com/swift-standards/swift-rss-standard): RSS 2.0 type definitions
- [swift-rfc-4287](https://github.com/swift-ietf/swift-rfc-4287): Atom type definitions (RFC 4287)
- [swift-rfc-3986](https://github.com/swift-ietf/swift-rfc-3986): URI
- [swift-rfc-5322](https://github.com/swift-ietf/swift-rfc-5322): Internet Message Format, including its date and time specification

## License

This project is licensed under the Apache License 2.0. See LICENSE for details.
