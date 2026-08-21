extension JSONFeed {

    public enum Error: Swift.Error, Hashable, Sendable {
        case itemRequiresContent(description: String)
        case invalidJSON(description: String)
        case invalidVersion(description: String)
    }
}
