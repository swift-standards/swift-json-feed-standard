public import RFC_5322
public import URI_Standard

extension JSONFeed {

    public struct Item: Hashable, Sendable {

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
    }
}
