# swift-json-feed-standard

Use this package when you publish or read a JSON Feed. Start from `JSONFeed.Feed` and add `JSONFeed.Item` values. Add the `JSON Feed Foundation Integration` product to encode and decode the JSON document. If you publish an RSS 2.0 feed instead, use swift-rss-standard.

## Laws

- A new `JSONFeed.Feed` carries the JSON Feed 1.1 version URL unless you pass another. Decoding accepts only the 1.1 and 1 version URLs and refuses any other.
- With `JSON Feed Foundation Integration`, members use the specification's snake case names, such as `home_page_url`, `content_html` and `size_in_bytes`. Members that are nil are left out.
- Decoding runs the same checks as the initializers, so an item without content fails to decode.
