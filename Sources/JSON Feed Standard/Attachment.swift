import URI_Standard

extension JSONFeed {
    /// Represents an attachment in a JSON Feed item
    public struct Attachment: Hashable, Sendable, Codable {
        /// The location of the attachment
        public let url: URI

        /// The MIME type of the attachment
        public let mimeType: String

        /// The title of the attachment
        public let title: String?

        /// The size of the attachment in bytes
        public let sizeInBytes: Int?

        /// The duration of the attachment in seconds (for audio/video)
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

        enum CodingKeys: String, CodingKey {
            case url
            case mimeType = "mime_type"
            case title
            case sizeInBytes = "size_in_bytes"
            case durationInSeconds = "duration_in_seconds"
        }

        /// Convert Swift.Duration to durationInSeconds
        ///
        /// Example:
        /// ```swift
        /// let attachment = JSONFeed.Attachment(
        ///     url: url,
        ///     mimeType: "audio/mpeg",
        ///     duration: .seconds(3665)
        /// )
        /// ```
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

        /// Get duration as Swift.Duration
        ///
        /// Example:
        /// ```swift
        /// if let duration = attachment.duration {
        ///     print("Duration: \(duration)")
        /// }
        /// ```
        @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
        public var duration: Swift.Duration? {
            guard let seconds = durationInSeconds else { return nil }
            return .seconds(seconds)
        }
    }
}
