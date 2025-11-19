import URI_Standard
import RFC_5322

extension JSONFeed {
    /// Represents an item in a JSON Feed
    public struct Item: Hashable, Sendable, Codable {
        /// Unique identifier for this item
        public let id: String

        /// The URL of the resource described by the item
        public let url: URI?

        /// The URL of a page elsewhere that is referenced by this item
        public let externalURL: URI?

        /// The title of the item
        public let title: String?

        /// The HTML content of the item
        public let contentHTML: String?

        /// The plain text content of the item
        public let contentText: String?

        /// A plain text summary of the item
        public let summary: String?

        /// The URL of the main image for the item
        public let image: URI?

        /// The URL of an image to use as a banner
        public let bannerImage: URI?

        /// The date the item was published
        public let datePublished: RFC_5322.Date?

        /// The date the item was modified
        public let dateModified: RFC_5322.Date?

        /// The authors of this item
        public let authors: [Author]?

        /// Tags associated with this item
        public let tags: [String]?

        /// The language of the item
        public let language: String?

        /// Attachments for this item
        public let attachments: [Attachment]?

        /// Creates a new item with validation
        /// - Throws: ValidationError.itemRequiresContent if neither contentHTML nor contentText is provided
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
        ) throws {
            // Validate that at least one content field is provided
            guard contentHTML != nil || contentText != nil else {
                throw ValidationError.itemRequiresContent(
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

        enum CodingKeys: String, CodingKey {
            case id
            case url
            case externalURL = "external_url"
            case title
            case contentHTML = "content_html"
            case contentText = "content_text"
            case summary
            case image
            case bannerImage = "banner_image"
            case datePublished = "date_published"
            case dateModified = "date_modified"
            case authors
            case tags
            case language
            case attachments
        }

        // Custom decoder to validate content requirement
        public init(from decoder: Decoder) throws {
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
            datePublished = try container.decodeIfPresent(RFC_5322.Date.self, forKey: .datePublished)
            dateModified = try container.decodeIfPresent(RFC_5322.Date.self, forKey: .dateModified)
            authors = try container.decodeIfPresent([Author].self, forKey: .authors)
            tags = try container.decodeIfPresent([String].self, forKey: .tags)
            language = try container.decodeIfPresent(String.self, forKey: .language)
            attachments = try container.decodeIfPresent([Attachment].self, forKey: .attachments)

            // Validate content requirement
            guard contentHTML != nil || contentText != nil else {
                throw ValidationError.itemRequiresContent(
                    description: "Item must have either contentHTML or contentText"
                )
            }
        }
    }
}
