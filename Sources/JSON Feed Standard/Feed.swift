import URI_Standard

extension JSONFeed {
    /// Represents a JSON Feed version 1.1
    public struct Feed: Hashable, Sendable, Codable {
        /// The version of the JSON Feed specification (always "https://jsonfeed.org/version/1.1")
        public let version: String

        /// The title of the feed
        public let title: String

        /// The URL of the website
        public let homePageURL: URI?

        /// The URL of the feed itself
        public let feedURL: URI?

        /// A description of the feed
        public let description: String?

        /// A description of the purpose of the feed
        public let userComment: String?

        /// The URL of a feed providing the next n items, where n is determined by the publisher
        public let nextURL: URI?

        /// The URL of an image for the feed
        public let icon: URI?

        /// The URL of an image for the feed suitable for use in a toolbar
        public let favicon: URI?

        /// The authors of the feed
        public let authors: [Author]?

        /// The primary language for the feed
        public let language: String?

        /// Whether the feed will never update again
        public let expired: Bool?

        /// Real-time notification hubs for this feed
        public let hubs: [Hub]?

        /// The items in the feed
        public let items: [Item]

        @_disfavoredOverload
        public init(
            title: String,
            homePageURL: URI? = nil,
            feedURL: URI? = nil,
            description: String? = nil,
            userComment: String? = nil,
            nextURL: URI? = nil,
            icon: URI? = nil,
            favicon: URI? = nil,
            authors: [Author]? = nil,
            language: String? = nil,
            expired: Bool? = nil,
            hubs: [Hub]? = nil,
            items: [Item] = []
        ) {
            self.version = "https://jsonfeed.org/version/1.1"
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

        enum CodingKeys: String, CodingKey {
            case version
            case title
            case homePageURL = "home_page_url"
            case feedURL = "feed_url"
            case description
            case userComment = "user_comment"
            case nextURL = "next_url"
            case icon
            case favicon
            case authors
            case language
            case expired
            case hubs
            case items
        }

        // Custom decoder to validate version
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            version = try container.decode(String.self, forKey: .version)

            // Validate version
            guard version == "https://jsonfeed.org/version/1.1" || version == "https://jsonfeed.org/version/1" else {
                throw Error.invalidVersion(
                    description: "Expected version 1.1 or 1, got: \(version)"
                )
            }

            title = try container.decode(String.self, forKey: .title)
            homePageURL = try container.decodeIfPresent(URI.self, forKey: .homePageURL)
            feedURL = try container.decodeIfPresent(URI.self, forKey: .feedURL)
            description = try container.decodeIfPresent(String.self, forKey: .description)
            userComment = try container.decodeIfPresent(String.self, forKey: .userComment)
            nextURL = try container.decodeIfPresent(URI.self, forKey: .nextURL)
            icon = try container.decodeIfPresent(URI.self, forKey: .icon)
            favicon = try container.decodeIfPresent(URI.self, forKey: .favicon)
            authors = try container.decodeIfPresent([Author].self, forKey: .authors)
            language = try container.decodeIfPresent(String.self, forKey: .language)
            expired = try container.decodeIfPresent(Bool.self, forKey: .expired)
            hubs = try container.decodeIfPresent([Hub].self, forKey: .hubs)
            items = try container.decode([Item].self, forKey: .items)
        }
    }
}
