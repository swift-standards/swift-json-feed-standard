import URI_Standard

extension JSONFeed {

    public struct Attachment: Hashable, Sendable, Codable {

        public let url: URI

        public let mimeType: String

        public let title: String?

        public let sizeInBytes: Int?

        public let durationInSeconds: Int?

        public init(
            url: URI,
            mimeType: String,
            title: String? = nil,
            sizeInBytes: Int? = nil,
            durationInSeconds: Int? = nil
        ) {
            self.url = url
            self.mimeType = mimeType
            self.title = title
            self.sizeInBytes = sizeInBytes
            self.durationInSeconds = durationInSeconds
        }

        @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
        public init(
            url: URI,
            mimeType: String,
            title: String? = nil,
            sizeInBytes: Int? = nil,
            duration: Swift.Duration
        ) {
            self.url = url
            self.mimeType = mimeType
            self.title = title
            self.sizeInBytes = sizeInBytes
            self.durationInSeconds = Int(duration.components.seconds)
        }
    }
}

extension JSONFeed.Attachment {

    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    public var duration: Swift.Duration? {
        guard let seconds = durationInSeconds else { return nil }
        return .seconds(seconds)
    }
}
