
extension JSONFeed {
    /// Errors that can occur during JSON Feed validation or processing
    public enum ValidationError: Error, Hashable, Sendable {
        case itemRequiresContent(description: String)
        case invalidJSON(description: String)
        case invalidVersion(description: String)
    }
}
