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
        case idle, loading, completed, error
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
                state = .error
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

    func paginateIfNeeded(currentIndex: Int, threshold: Int = 1) {
         guard hasMoreData, !isLoading, state != .error else { return }

         let triggerIndex = max(0, items.count - threshold)
         if currentIndex >= triggerIndex {
             loadNextPage()
         }
     }
}

extension Paginator.PageState: Equatable {
    public static func == (lhs: Paginator<Item>.PageState, rhs: Paginator<Item>.PageState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.completed, .completed):
            return true
        case (.error, .error):
            return true // Only compares case, not the error itself
        default:
            return false
        }
    }
}

