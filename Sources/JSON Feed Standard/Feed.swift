import URI_Standard

extension JSONFeed {

    public struct Feed: Hashable, Sendable, Codable {

        public let version: String

        public let title: String

        public let homePageURL: URI?

        public let feedURL: URI?

        public let description: String?

        public let userComment: String?

        public let nextURL: URI?

        public let icon: URI?

        public let favicon: URI?

        public let authors: [Author]?

        public let language: String?

        public let expired: Bool?

        public let hubs: [Hub]?

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

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            version = try container.decode(String.self, forKey: .version)

            guard
                version == "https://jsonfeed.org/version/1.1"
                    || version == "https://jsonfeed.org/version/1"
            else {
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
