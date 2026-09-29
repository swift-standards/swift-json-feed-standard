import RFC_3986_Foundation_Integration
public import JSON_Feed_Standard
import URI_Standard

extension JSONFeed.Feed: Encodable, Decodable {

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

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let version = try container.decode(String.self, forKey: .version)

        guard
            version == JSONFeed.Feed.currentVersion || version == JSONFeed.Feed.legacyVersion
        else {
            throw JSONFeed.Error.invalidVersion(
                description: "Expected version 1.1 or 1, got: \(version)"
            )
        }

        self.init(
            version: version,
            title: try container.decode(String.self, forKey: .title),
            homePageURL: try container.decodeIfPresent(URI.self, forKey: .homePageURL),
            feedURL: try container.decodeIfPresent(URI.self, forKey: .feedURL),
            description: try container.decodeIfPresent(String.self, forKey: .description),
            userComment: try container.decodeIfPresent(String.self, forKey: .userComment),
            nextURL: try container.decodeIfPresent(URI.self, forKey: .nextURL),
            icon: try container.decodeIfPresent(URI.self, forKey: .icon),
            favicon: try container.decodeIfPresent(URI.self, forKey: .favicon),
            authors: try container.decodeIfPresent([JSONFeed.Author].self, forKey: .authors),
            language: try container.decodeIfPresent(String.self, forKey: .language),
            expired: try container.decodeIfPresent(Bool.self, forKey: .expired),
            hubs: try container.decodeIfPresent([JSONFeed.Hub].self, forKey: .hubs),
            items: try container.decode([JSONFeed.Item].self, forKey: .items)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(version, forKey: .version)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(homePageURL, forKey: .homePageURL)
        try container.encodeIfPresent(feedURL, forKey: .feedURL)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(userComment, forKey: .userComment)
        try container.encodeIfPresent(nextURL, forKey: .nextURL)
        try container.encodeIfPresent(icon, forKey: .icon)
        try container.encodeIfPresent(favicon, forKey: .favicon)
        try container.encodeIfPresent(authors, forKey: .authors)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(expired, forKey: .expired)
        try container.encodeIfPresent(hubs, forKey: .hubs)
        try container.encode(items, forKey: .items)
    }
}
