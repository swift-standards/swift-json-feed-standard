extension JSONFeed.Item {
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
}
