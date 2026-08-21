import URI_Standard

extension JSONFeed {

    public struct Hub: Hashable, Sendable, Codable {

        public let type: String

        public let url: URI

        public init(
            type: String,
            url: URI
        ) {
            self.type = type
            self.url = url
        }
    }
}
