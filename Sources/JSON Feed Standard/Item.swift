import RFC_5322
import URI_Standard

extension JSONFeed {

    public struct Item: Hashable, Sendable, Codable {

        public let id: String

        public let url: URI?

        public let externalURL: URI?

        public let title: String?

        public let contentHTML: String?

        public let contentText: String?

        public let summary: String?

        public let image: URI?

        public let bannerImage: URI?

        public let datePublished: RFC_5322.Date?

        public let dateModified: RFC_5322.Date?

        public let authors: [Author]?

        public let tags: [String]?

        public let language: String?

        public let attachments: [Attachment]?

        @_disfavoredOverload
        public init(
            id: String,
            url: URI? = nil,
            externalURL: URI? = nil,
            title: String? = nil,
            contentHTML: String? = nil,
            contentText: String? = nil,
            summary: String? = nil,
            image: URI? = nil,
            bannerImage: URI? = nil,
            datePublished: RFC_5322.Date? = nil,
            dateModified: RFC_5322.Date? = nil,
            authors: [Author]? = nil,
            tags: [String]? = nil,
            language: String? = nil,
            attachments: [Attachment]? = nil
        ) throws(JSONFeed.Error) {

            guard contentHTML != nil || contentText != nil else {
                throw .itemRequiresContent(
                    description: "Item must have either contentHTML or contentText"
                )
            }

            self.id = id
            self.url = url
            self.externalURL = externalURL
            self.title = title
            self.contentHTML = contentHTML
            self.contentText = contentText
            self.summary = summary
            self.image = image
            self.bannerImage = bannerImage
            self.datePublished = datePublished
            self.dateModified = dateModified
            self.authors = authors
            self.tags = tags
            self.language = language
            self.attachments = attachments
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(String.self, forKey: .id)
            url = try container.decodeIfPresent(URI.self, forKey: .url)
            externalURL = try container.decodeIfPresent(URI.self, forKey: .externalURL)
            title = try container.decodeIfPresent(String.self, forKey: .title)
            contentHTML = try container.decodeIfPresent(String.self, forKey: .contentHTML)
            contentText = try container.decodeIfPresent(String.self, forKey: .contentText)
            summary = try container.decodeIfPresent(String.self, forKey: .summary)
            image = try container.decodeIfPresent(URI.self, forKey: .image)
            bannerImage = try container.decodeIfPresent(URI.self, forKey: .bannerImage)
            datePublished = try container.decodeIfPresent(
                RFC_5322.Date.self,
                forKey: .datePublished
            )
            dateModified = try container.decodeIfPresent(RFC_5322.Date.self, forKey: .dateModified)
            authors = try container.decodeIfPresent([Author].self, forKey: .authors)
            tags = try container.decodeIfPresent([String].self, forKey: .tags)
            language = try container.decodeIfPresent(String.self, forKey: .language)
            attachments = try container.decodeIfPresent([Attachment].self, forKey: .attachments)

            guard contentHTML != nil || contentText != nil else {
                throw Error.itemRequiresContent(
                    description: "Item must have either contentHTML or contentText"
                )
            }
        }
    }
}
