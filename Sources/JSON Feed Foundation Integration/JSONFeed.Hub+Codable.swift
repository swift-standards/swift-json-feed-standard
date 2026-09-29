import RFC_3986_Foundation_Integration
public import JSON_Feed_Standard
import URI_Standard

extension JSONFeed.Hub: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case type
        case url
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.init(
            type: try container.decode(String.self, forKey: .type),
            url: try container.decode(URI.self, forKey: .url)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(url, forKey: .url)
    }
}
