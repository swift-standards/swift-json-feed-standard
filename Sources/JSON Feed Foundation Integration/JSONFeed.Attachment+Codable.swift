import RFC_3986_Foundation_Integration
public import JSON_Feed_Standard
import URI_Standard

extension JSONFeed.Attachment: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case url
        case mimeType = "mime_type"
        case title
        case sizeInBytes = "size_in_bytes"
        case durationInSeconds = "duration_in_seconds"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.init(
            url: try container.decode(URI.self, forKey: .url),
            mimeType: try container.decode(String.self, forKey: .mimeType),
            title: try container.decodeIfPresent(String.self, forKey: .title),
            sizeInBytes: try container.decodeIfPresent(Int.self, forKey: .sizeInBytes),
            durationInSeconds: try container.decodeIfPresent(
                Int.self,
                forKey: .durationInSeconds
            )
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(url, forKey: .url)
        try container.encode(mimeType, forKey: .mimeType)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(sizeInBytes, forKey: .sizeInBytes)
        try container.encodeIfPresent(durationInSeconds, forKey: .durationInSeconds)
    }
}
