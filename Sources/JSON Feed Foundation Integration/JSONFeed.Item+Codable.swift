public import JSON_Feed_Standard
import RFC_3339
import RFC_3986_Foundation_Integration
import RFC_5322
import RFC_5322_Foundation_Integration
import RFC_5646
import URI_Standard

extension JSONFeed.Item: Encodable, Decodable {

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

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        try self.init(
            id: try container.decode(String.self, forKey: .id),
            url: try container.decodeIfPresent(URI.self, forKey: .url),
            externalURL: try container.decodeIfPresent(URI.self, forKey: .externalURL),
            title: try container.decodeIfPresent(String.self, forKey: .title),
            contentHTML: try container.decodeIfPresent(String.self, forKey: .contentHTML),
            contentText: try container.decodeIfPresent(String.self, forKey: .contentText),
            summary: try container.decodeIfPresent(String.self, forKey: .summary),
            image: try container.decodeIfPresent(URI.self, forKey: .image),
            bannerImage: try container.decodeIfPresent(URI.self, forKey: .bannerImage),
            datePublished: try Self.date(
                container.decodeIfPresent(String.self, forKey: .datePublished),
                in: container,
                forKey: .datePublished
            ),
            dateModified: try Self.date(
                container.decodeIfPresent(String.self, forKey: .dateModified),
                in: container,
                forKey: .dateModified
            ),
            authors: try container.decodeIfPresent([JSONFeed.Author].self, forKey: .authors),
            tags: try container.decodeIfPresent([String].self, forKey: .tags),
            language: try? container.decodeIfPresent(RFC_5646.LanguageTag.self, forKey: .language),
            attachments: try container.decodeIfPresent(
                [JSONFeed.Attachment].self,
                forKey: .attachments
            )
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(externalURL, forKey: .externalURL)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(contentHTML, forKey: .contentHTML)
        try container.encodeIfPresent(contentText, forKey: .contentText)
        try container.encodeIfPresent(summary, forKey: .summary)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(bannerImage, forKey: .bannerImage)
        try container.encodeIfPresent(datePublished?.rfc3339.description, forKey: .datePublished)
        try container.encodeIfPresent(dateModified?.rfc3339.description, forKey: .dateModified)
        try container.encodeIfPresent(authors, forKey: .authors)
        try container.encodeIfPresent(tags, forKey: .tags)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(attachments, forKey: .attachments)
    }
}

extension JSONFeed.Item {

    fileprivate static func date(
        _ string: String?,
        in container: KeyedDecodingContainer<CodingKeys>,
        forKey key: CodingKeys
    ) throws(DecodingError) -> RFC_5322.Date? {
        guard let string else {
            return nil
        }
        do throws(RFC_3339.DateTime.Error) {
            return RFC_5322.Date(rfc3339: try RFC_3339.DateTime(string))
        } catch {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: container,
                debugDescription: "Expected an RFC 3339 date, got: \(string)"
            )
        }
    }
}

extension RFC_5322.DateTime {

    fileprivate init(rfc3339 dateTime: RFC_3339.DateTime) {
        let offset = dateTime.offset.seconds
        self.init(
            secondsSinceEpoch: Int(dateTime.time.secondsSinceEpoch) - offset,
            timezoneOffsetSeconds: offset
        )
    }

    fileprivate var rfc3339: RFC_3339.DateTime {
        let offsetSeconds = timezoneOffsetSeconds
        do throws(RFC_3339.Offset.Error) {
            let offset = try RFC_3339.Offset(seconds: offsetSeconds)
            return RFC_3339.DateTime(
                time: Gregorian.DateTime(secondsSinceEpoch: secondsSinceEpoch + offsetSeconds),
                offset: offset
            )
        } catch {
            return RFC_3339.DateTime(time: time, offset: .utc)
        }
    }
}
