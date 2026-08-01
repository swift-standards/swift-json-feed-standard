extension JSONFeed.Feed {
    enum CodingKeys: String, CodingKey {
        case version
        case title
        case homePageURL = "home_page_url"
        case feedURL = "feed_url"
        case description
        case userComment = "user_comment"
        case nextURL = "next_url"
        case icon
        case favicon
        case authors
        case language
        case expired
        case hubs
        case items
    }
}
