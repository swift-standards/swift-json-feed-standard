import URI_Standard

extension JSONFeed {

    public struct Author: Hashable, Sendable, Codable {

        public let name: String?

        public let url: URI?

        public let avatar: URI?

        public init(
            name: String? = nil,
            url: URI? = nil,
            avatar: URI? = nil
        ) {
            self.name = name
            self.url = url
            self.avatar = avatar
        }
    }
}

extension JSONFeed.Author: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.init(name: value, url: nil, avatar: nil)
    }
}
