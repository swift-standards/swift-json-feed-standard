public import RFC_5646
public import URI_Standard

extension JSONFeed {

    public struct Feed: Hashable, Sendable {

        public let version: URI

        public let title: String

        public let homePageURL: URI?

        public let feedURL: URI?

        public let description: String?

        public let userComment: String?

        public let nextURL: URI?

        public let icon: URI?

        public let favicon: URI?

        public let authors: [Author]?

        public let language: RFC_5646.LanguageTag?

        public let expired: Bool?

        public let hubs: [Hub]?

        public let items: [Item]

        @_disfavoredOverload
        public init(
            version: URI = JSONFeed.Feed.currentVersion,
            title: String,
            homePageURL: URI? = nil,
            feedURL: URI? = nil,
            description: String? = nil,
            userComment: String? = nil,
            nextURL: URI? = nil,
            icon: URI? = nil,
            favicon: URI? = nil,
            authors: [Author]? = nil,
            language: RFC_5646.LanguageTag? = nil,
            expired: Bool? = nil,
            hubs: [Hub]? = nil,
            items: [Item] = []
        ) {
            self.version = version
            self.title = title
            self.homePageURL = homePageURL
            self.feedURL = feedURL
            self.description = description
            self.userComment = userComment
            self.nextURL = nextURL
            self.icon = icon
            self.favicon = favicon
            self.authors = authors
            self.language = language
            self.expired = expired
            self.hubs = hubs
            self.items = items
        }
    }
}

extension JSONFeed.Feed {

    public static let currentVersion = URI(unchecked: "https://jsonfeed.org/version/1.1")

    public static let legacyVersion = URI(unchecked: "https://jsonfeed.org/version/1")
}
