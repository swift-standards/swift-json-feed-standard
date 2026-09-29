import RFC_3986_Foundation_Integration
public import JSON_Feed_Standard
import URI_Standard

extension JSONFeed.Author: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case name
        case url
        case avatar
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.init(
            name: try container.decodeIfPresent(String.self, forKey: .name),
            url: try container.decodeIfPresent(URI.self, forKey: .url),
            avatar: try container.decodeIfPresent(URI.self, forKey: .avatar)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(avatar, forKey: .avatar)
    }
}
