
extension JSONFeed {
    /// Represents an author in a JSON Feed
    public struct Author: Hashable, Sendable, Codable {
        /// The author's name
        public let name: String?

        /// The URL of a site owned by the author
        public let url: URL?

        /// The URL for an image for the author
        public let avatar: URL?

        public init(
            name: String? = nil,
            url: URL? = nil,
            avatar: URL? = nil
        ) {
            self.name = name
            self.url = url
            self.avatar = avatar
        }

        enum CodingKeys: String, CodingKey {
            case name
            case url
            case avatar
        }
    }
}

// MARK: - ExpressibleByStringLiteral
extension JSONFeed.Author: ExpressibleByStringLiteral {
    /// Creates an author from a string literal (just name, no URL or avatar)
    ///
    /// Example:
    /// ```swift
    /// let author: JSONFeed.Author = "John Doe"
    /// // Equivalent to: JSONFeed.Author(name: "John Doe")
    /// ```
    public init(stringLiteral value: String) {
        self.init(name: value, url: nil, avatar: nil)
    }
}
