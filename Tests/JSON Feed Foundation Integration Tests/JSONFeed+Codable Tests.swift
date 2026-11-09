import Foundation
import JSON_Feed_Foundation_Integration
import JSON_Feed_Standard
import RFC_5322
import RFC_9110
import Testing
import URI_Standard

@Suite
struct `JSONFeed+Codable Tests` {

    @Test
    func `a feed round trips through JSON`() throws {
        let feed = JSONFeed.Feed(
            title: "My Blog",
            homePageURL: try URI("https://example.com"),
            feedURL: try URI("https://example.com/feed.json"),
            authors: ["Jane Doe"],
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

        let encoded = try JSONEncoder().encode(feed)

        #expect(try JSONDecoder().decode(JSONFeed.Feed.self, from: encoded) == feed)
    }

    @Test
    func `a feed decodes the specified member names`() throws {
        let document = """
            {
              "version": "https://jsonfeed.org/version/1.1",
              "title": "My Blog",
              "home_page_url": "https://example.com",
              "items": [
                {
                  "id": "1",
                  "content_text": "Hello, world!",
                  "external_url": "https://external.example.com"
                }
              ]
            }
            """

        let feed = try JSONDecoder().decode(
            JSONFeed.Feed.self,
            from: Data(document.utf8)
        )

        #expect(feed.homePageURL?.value == "https://example.com")
        #expect(feed.items.first?.externalURL?.value == "https://external.example.com")
        #expect(feed.items.first?.contentText == "Hello, world!")
    }

    @Test
    func `a feed of an unknown version is rejected`() throws {
        let document = """
            {
              "version": "https://jsonfeed.org/version/2",
              "title": "My Blog",
              "items": []
            }
            """

        #expect(
            throws: JSONFeed.Error.invalidVersion(
                description: "Expected version 1.1 or 1, got: https://jsonfeed.org/version/2"
            )
        ) {
            _ = try JSONDecoder().decode(JSONFeed.Feed.self, from: Data(document.utf8))
        }
    }

    @Test
    func `an item without content is rejected while decoding`() throws {
        let document = """
            {
              "version": "https://jsonfeed.org/version/1.1",
              "title": "My Blog",
              "items": [{ "id": "1" }]
            }
            """

        #expect(throws: JSONFeed.Error.self) {
            _ = try JSONDecoder().decode(JSONFeed.Feed.self, from: Data(document.utf8))
        }
    }

    @Test
    func `an attachment codes its duration in seconds`() throws {
        let attachment = JSONFeed.Attachment(
            url: try URI("https://example.com/audio.mp3"),
            mimeType: .mp3,
            duration: .seconds(180)
        )

        let encoded = try JSONEncoder().encode(attachment)
        let decoded = try JSONDecoder().decode(JSONFeed.Attachment.self, from: encoded)

        #expect(decoded == attachment)
        #expect(decoded.durationInSeconds == 180)
    }

    @Test
    func `an item decodes RFC 3339 dates as the specification writes them`() throws {
        let document = """
            {
              "id": "2347259",
              "url": "https://example.org/2347259",
              "content_text": "Cats are neat.",
              "date_published": "2010-02-07T14:04:00-05:00",
              "date_modified": "2010-02-07T19:04:00.5Z"
            }
            """

        let item = try JSONDecoder().decode(JSONFeed.Item.self, from: Data(document.utf8))

        #expect(item.datePublished?.secondsSinceEpoch == 1_265_569_440)
        #expect(item.datePublished?.timezoneOffsetSeconds == -18_000)
        #expect(item.dateModified?.secondsSinceEpoch == 1_265_569_440)
    }

    @Test
    func `an item encodes its dates in RFC 3339`() throws {
        let item = try JSONFeed.Item(
            id: "1",
            contentText: "Hello",
            datePublished: try RFC_5322.Date(year: 2025, month: 1, day: 1),
            dateModified: try RFC_5322.Date(
                year: 2025,
                month: 1,
                day: 2,
                hour: 9,
                minute: 30,
                timezoneOffsetSeconds: 3_600
            )
        )

        let object = try JSONSerialization.jsonObject(with: JSONEncoder().encode(item)) as? [String: Any]

        #expect(object?["date_published"] as? String == "2025-01-01T00:00:00Z")
        #expect(object?["date_modified"] as? String == "2025-01-02T09:30:00+01:00")
    }

    @Test
    func `an item with an RFC 5322 date is rejected while decoding`() throws {
        let document = """
            {
              "id": "1",
              "content_text": "Hello",
              "date_published": "Wed, 01 Jan 2025 00:00:00 +0000"
            }
            """

        #expect(throws: DecodingError.self) {
            _ = try JSONDecoder().decode(JSONFeed.Item.self, from: Data(document.utf8))
        }
    }
}
