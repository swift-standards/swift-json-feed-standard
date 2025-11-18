
extension JSONFeed {
    /// Errors that can occur during JSON Feed validation or processing
    public enum ValidationError: Error, Hashable, Sendable {
        case itemRequiresContent(description: String)
        case invalidJSON(description: String)
        case invalidVersion(description: String)
    }
}

extension JSONFeed.ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .itemRequiresContent(let description):
            return "Item requires content: \(description)"
        case .invalidJSON(let description):
            return "Invalid JSON: \(description)"
        case .invalidVersion(let description):
            return "Invalid version: \(description)"
        }
    }
}
