import Testing
@testable import JSONFeed

@Suite
struct `JSON Feed Tests` {
    @Test
    func `Basic feed generation`() throws {
        let feed = JSONFeed.Feed(
            title: "Test Feed",
            items: []
        )

        #expect(feed.version == "https://jsonfeed.org/version/1.1")
        #expect(feed.title == "Test Feed")
        #expect(feed.items.isEmpty)
    }

    @Test
    func `Feed with all optional fields`() throws {
        let feed = JSONFeed.Feed(
            title: "My Test Feed",
            homePageURL: URL(string: "https://example.com")!,
            feedURL: URL(string: "https://example.com/feed.json")!,
            description: "A test feed",
            userComment: "This is a test",
            nextURL: URL(string: "https://example.com/feed/2.json")!,
            icon: URL(string: "https://example.com/icon.png")!,
            favicon: URL(string: "https://example.com/favicon.ico")!,
            authors: [
                JSONFeed.Author(
                    name: "John Doe",
                    url: URL(string: "https://johndoe.com")!,
                    avatar: URL(string: "https://johndoe.com/avatar.jpg")!
                )
            ],
            language: "en-US",
            expired: false,
            hubs: [
                JSONFeed.Hub(
                    type: "WebSub",
                    url: URL(string: "https://example.com/hub")!
                )
            ],
            items: []
        )

        #expect(feed.homePageURL?.absoluteString == "https://example.com")
        #expect(feed.feedURL?.absoluteString == "https://example.com/feed.json")
        #expect(feed.description == "A test feed")
        #expect(feed.userComment == "This is a test")
        #expect(feed.language == "en-US")
        #expect(feed.expired == false)
        #expect(feed.authors?.count == 1)
        #expect(feed.hubs?.count == 1)
    }

    @Test
    func `Item with HTML content`() throws {
        let item = try JSONFeed.Item(
            id: "1",
            url: URL(string: "https://example.com/post1")!,
            title: "Test Post",
            contentHTML: "<p>Hello, world!</p>"
        )

        #expect(item.id == "1")
        #expect(item.title == "Test Post")
        #expect(item.contentHTML == "<p>Hello, world!</p>")
        #expect(item.contentText == nil)
    }

    @Test
    func `Item with text content`() throws {
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
    func `Item with both HTML and text content`() throws {
        let item = try JSONFeed.Item(
            id: "3",
            contentHTML: "<p>HTML version</p>",
            contentText: "Text version"
        )

        #expect(item.contentHTML == "<p>HTML version</p>")
        #expect(item.contentText == "Text version")
    }

    @Test
    func `Item without content throws error`() {
        #expect(throws: JSONFeed.ValidationError.self) {
            _ = try JSONFeed.Item(
                id: "4",
                title: "No Content"
            )
        }
    }

    @Test
    func `Item with all fields`() throws {
        let date = Date()
        let item = try JSONFeed.Item(
            id: "5",
            url: URL(string: "https://example.com/post5")!,
            externalURL: URL(string: "https://external.com/reference")!,
            title: "Complete Post",
            contentHTML: "<p>Content</p>",
            contentText: "Content",
            summary: "A summary",
            image: URL(string: "https://example.com/image.jpg")!,
            bannerImage: URL(string: "https://example.com/banner.jpg")!,
            datePublished: date,
            dateModified: date,
            authors: [
                JSONFeed.Author(name: "Jane Doe")
            ],
            tags: ["test", "example"],
            language: "en",
            attachments: [
                JSONFeed.Attachment(
                    url: URL(string: "https://example.com/file.mp3")!,
                    mimeType: "audio/mpeg",
                    title: "Audio File",
                    sizeInBytes: 1024000,
                    durationInSeconds: 180
                )
            ]
        )

        #expect(item.externalURL?.absoluteString == "https://external.com/reference")
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
    func `Author type`() {
        let author = JSONFeed.Author(
            name: "Test Author",
            url: URL(string: "https://author.com")!,
            avatar: URL(string: "https://author.com/avatar.jpg")!
        )

        #expect(author.name == "Test Author")
        #expect(author.url?.absoluteString == "https://author.com")
        #expect(author.avatar?.absoluteString == "https://author.com/avatar.jpg")
    }

    @Test
    func `Attachment type`() {
        let attachment = JSONFeed.Attachment(
            url: URL(string: "https://example.com/video.mp4")!,
            mimeType: "video/mp4",
            title: "Video",
            sizeInBytes: 5242880,
            durationInSeconds: 300
        )

        #expect(attachment.url.absoluteString == "https://example.com/video.mp4")
        #expect(attachment.mimeType == "video/mp4")
        #expect(attachment.title == "Video")
        #expect(attachment.sizeInBytes == 5242880)
        #expect(attachment.durationInSeconds == 300)
    }

    @Test
    func `Hub type`() {
        let hub = JSONFeed.Hub(
            type: "WebSub",
            url: URL(string: "https://hub.example.com")!
        )

        #expect(hub.type == "WebSub")
        #expect(hub.url.absoluteString == "https://hub.example.com")
    }
}
