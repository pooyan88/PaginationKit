//
//  Paginator.swift
//  PaginationKit
//
//  Created by Pooyan J on 4/24/1404 AP.
//

import Foundation

@MainActor
public final class Paginator<Item: Sendable>: ObservableObject {

    public enum PageState {
        case idle, loading, completed, error(Error)
    }

    @Published public private(set) var items: [Item] = []
    @Published public private(set) var state: PageState = .idle

    public private(set) var hasMoreData: Bool = true
    private var isLoading = false

    private var start: Int
    private let pageSize: Int

    private let fetchPage: (Int, Int) async throws -> [Item]

    public init(start: Int = 0, pageSize: Int = 10,
                fetchPage: @escaping (Int, Int) async throws -> [Item]) {
        self.start = start
        self.pageSize = pageSize
        self.fetchPage = fetchPage
    }

    public func loadNextPage() {
        guard !isLoading && hasMoreData else { return }

        isLoading = true
        state = .loading

        Task {
            do {
                let newItems = try await fetchPage(start, pageSize)
                items.append(contentsOf: newItems)
                start += newItems.count
                hasMoreData = newItems.count == pageSize
                state = .completed
            } catch {
                state = .error(error)
            }
            isLoading = false
        }
    }

    public func reset(start: Int = 0) {
        self.start = start
        self.items.removeAll()
        self.hasMoreData = true
        self.state = .idle
        loadNextPage()
    }
}

