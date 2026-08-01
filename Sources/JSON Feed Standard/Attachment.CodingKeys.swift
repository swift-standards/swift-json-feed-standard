extension JSONFeed.Attachment {
    enum CodingKeys: String, CodingKey {
        case url
        case mimeType = "mime_type"
        case title
        case sizeInBytes = "size_in_bytes"
        case durationInSeconds = "duration_in_seconds"
    }
}
