import RFC_5322
import Testing
import URI_Standard

import JSON_Feed_Standard

@Suite
struct `JSONFeed Tests` {

    @Test
    func `a feed carries the JSON Feed 1.1 version`() throws {
        let feed = JSONFeed.Feed(title: "Test Feed")

        #expect(feed.version == "https://jsonfeed.org/version/1.1")
        #expect(feed.title == "Test Feed")
        #expect(feed.items.isEmpty)
    }

    @Test
    func `a feed carries every optional element`() throws {
        let feed = JSONFeed.Feed(
            title: "My Test Feed",
            homePageURL: try URI("https://example.com"),
            feedURL: try URI("https://example.com/feed.json"),
            description: "A test feed",
            userComment: "This is a test",
            nextURL: try URI("https://example.com/feed/2.json"),
            icon: try URI("https://example.com/icon.png"),
            favicon: try URI("https://example.com/favicon.ico"),
            authors: [
                JSONFeed.Author(
                    name: "John Doe",
                    url: try URI("https://johndoe.com"),
                    avatar: try URI("https://johndoe.com/avatar.jpg")
                )
            ],
            language: "en-US",
            expired: false,
            hubs: [
                JSONFeed.Hub(
                    type: "WebSub",
                    url: try URI("https://example.com/hub")
                )
            ]
        )

        #expect(feed.homePageURL?.value == "https://example.com")
        #expect(feed.feedURL?.value == "https://example.com/feed.json")
        #expect(feed.description == "A test feed")
        #expect(feed.userComment == "This is a test")
        #expect(feed.language == "en-US")
        #expect(feed.expired == false)
        #expect(feed.authors?.count == 1)
        #expect(feed.hubs?.count == 1)
    }

    @Test
    func `an item carries HTML content`() throws {
        let item = try JSONFeed.Item(
            id: "1",
            url: try URI("https://example.com/post1"),
            title: "Test Post",
            contentHTML: "<p>Hello, world!</p>"
        )

        #expect(item.id == "1")
        #expect(item.title == "Test Post")
        #expect(item.contentHTML == "<p>Hello, world!</p>")
        #expect(item.contentText == nil)
    }

    @Test
    func `an item carries text content`() throws {
        let item = try JSONFeed.Item(
            id: "2",
            title: "Plain Text Post",
            contentText: "Hello, world!"
        )

        #expect(item.id == "2")
        #expect(item.contentText == "Hello, world!")
        #expect(item.contentHTML == nil)
    }

    @Test
    func `an item carries both HTML and text content`() throws {
        let item = try JSONFeed.Item(
            id: "3",
            contentHTML: "<p>HTML version</p>",
            contentText: "Text version"
        )

        #expect(item.contentHTML == "<p>HTML version</p>")
        #expect(item.contentText == "Text version")
    }

    @Test
    func `an item without content is rejected`() {
        #expect(throws: JSONFeed.Error.self) {
            _ = try JSONFeed.Item(
                id: "4",
                title: "No Content"
            )
        }
    }

    @Test
    func `an item carries every optional element`() throws {
        let date = try RFC_5322.Date(year: 2025, month: 1, day: 1)
        let item = try JSONFeed.Item(
            id: "5",
            url: try URI("https://example.com/post5"),
            externalURL: try URI("https://external.com/reference"),
            title: "Complete Post",
            contentHTML: "<p>Content</p>",
            contentText: "Content",
            summary: "A summary",
            image: try URI("https://example.com/image.jpg"),
            bannerImage: try URI("https://example.com/banner.jpg"),
            datePublished: date,
            dateModified: date,
            authors: [
                JSONFeed.Author(name: "Jane Doe")
            ],
            tags: ["test", "example"],
            language: "en",
            attachments: [
                JSONFeed.Attachment(
                    url: try URI("https://example.com/file.mp3"),
                    mimeType: "audio/mpeg",
                    title: "Audio File",
                    sizeInBytes: 1_024_000,
                    durationInSeconds: 180
                )
            ]
        )

        #expect(item.externalURL?.value == "https://external.com/reference")
        #expect(item.summary == "A summary")
        #expect(item.image != nil)
        #expect(item.bannerImage != nil)
        #expect(item.datePublished == date)
        #expect(item.dateModified == date)
        #expect(item.authors?.count == 1)
        #expect(item.tags?.count == 2)
        #expect(item.language == "en")
        #expect(item.attachments?.count == 1)
    }

    @Test
    func `an author names a person and their pages`() throws {
        let author = JSONFeed.Author(
            name: "Test Author",
            url: try URI("https://author.com"),
            avatar: try URI("https://author.com/avatar.jpg")
        )

        #expect(author.name == "Test Author")
        #expect(author.url?.value == "https://author.com")
        #expect(author.avatar?.value == "https://author.com/avatar.jpg")
    }

    @Test
    func `an author is expressible by a string literal`() {
        let author: JSONFeed.Author = "Test Author"

        #expect(author.name == "Test Author")
        #expect(author.url == nil)
    }

    @Test
    func `an attachment describes an enclosed file`() throws {
        let attachment = JSONFeed.Attachment(
            url: try URI("https://example.com/video.mp4"),
            mimeType: "video/mp4",
            title: "Video",
            sizeInBytes: 5_242_880,
            durationInSeconds: 300
        )

        #expect(attachment.url.value == "https://example.com/video.mp4")
        #expect(attachment.mimeType == "video/mp4")
        #expect(attachment.title == "Video")
        #expect(attachment.sizeInBytes == 5_242_880)
        #expect(attachment.durationInSeconds == 300)
    }

    @Test
    func `an attachment states its duration as a Duration`() throws {
        let attachment = JSONFeed.Attachment(
            url: try URI("https://example.com/audio.mp3"),
            mimeType: "audio/mpeg",
            duration: .seconds(300)
        )

        #expect(attachment.durationInSeconds == 300)
        #expect(attachment.duration == Swift.Duration.seconds(300))
    }

    @Test
    func `a hub names a push protocol and endpoint`() throws {
        let hub = JSONFeed.Hub(
            type: "WebSub",
            url: try URI("https://hub.example.com")
        )

        #expect(hub.type == "WebSub")
        #expect(hub.url.value == "https://hub.example.com")
    }
}
