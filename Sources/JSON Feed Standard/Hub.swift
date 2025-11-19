import URI_Standard

extension JSONFeed {
    /// Represents a real-time notification hub for a JSON Feed
    public struct Hub: Hashable, Sendable, Codable {
        /// The type of the hub (e.g., "rssCloud", "WebSub")
        public let type: String

        /// The URI of the hub
        public let url: URI

        public init(
            type: String,
            url: URI
        ) {
            self.type = type
            self.url = url
        }

        enum CodingKeys: String, CodingKey {
            case type
            case url
        }
    }
}
