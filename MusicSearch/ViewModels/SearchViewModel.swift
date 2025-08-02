//
//  SearchViewModel.swift
//  MusicSearch
//
//  Created by Vladimir Bakalov on 02/08/2025.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var tracks: [Track] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var searchTask: Task<Void, Error>?

    private let service: iTunesAPIServiceProtocol

    init(service: iTunesAPIServiceProtocol = iTunesAPIService()) {
        self.service = service
    }

    func search() {
        searchTask?.cancel()

        guard !searchText.isEmpty else {
            tracks = []
            return
        }

        isLoading = true
        errorMessage = nil

        // Cancellable Task
        searchTask = Task { [weak self] in
            guard let self = self else { return }

            // Forced delay to show progress view
            do {
              try await Task.sleep(nanoseconds: 500_000_000)
            } catch is CancellationError {
              return
            }

            do {
                let results = try await service.searchTracks(term: self.searchText)
                try Task.checkCancellation()
                self.tracks = results
            } catch is CancellationError {
                return
            } catch {
                self.errorMessage = error.localizedDescription
                print("Could not load tracks: \(error.localizedDescription)")
            }

            self.isLoading = false
        }
    }

    deinit {
        searchTask?.cancel()
    }
}
