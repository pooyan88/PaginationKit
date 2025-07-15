# PaginationKit

A simple Swift paginator utility for handling paginated data loading with async/await, supporting SwiftUI and UIKit.

## 📦 Installation

### Swift Package Manager (SPM)

You can add PaginationKit via Xcode:

https://github.com/pooyan88/PaginationKit.git


Or add the following in your `Package.swift`:

```swift
.package(url: "https://github.com/pooyan88/PaginationKit.git", from: "1.0.0")
🚀 Usage Example

import PaginationKit

final class ExampleViewModel: ObservableObject {
    @Published private(set) var paginator: Paginator<MyModel>?

    init() {
        paginator = Paginator(start: 0, pageSize: 20) { start, pageSize in
            // Your async API call that fetches [MyModel]
            try await YourAPI.fetchItems(offset: start, limit: pageSize)
        }
    }

    func loadMore() {
        paginator?.loadNextPage()
    }

    func refresh() {
        paginator?.reset()
    }
}
```

🧩 API Reference:

Paginator<Item>
Property	Description
items	The loaded items [Item]
state	Current loading state (idle, loading, completed, error)
hasMoreData	Indicates if more data is available to load

Methods:

loadNextPage(): Loads the next page if available.
reset(start:): Resets the paginator and starts from the given index.

📋 Requirements:
iOS 13.0+
Swift 5.7+

📄 License:
MIT License
