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

    private let service: iTunesAPIServiceProtocol

    init(service: iTunesAPIServiceProtocol = iTunesAPIService()) {
        self.service = service
    }

    func search() {
        guard !searchText.isEmpty else {
            tracks = []
            return
        }

        Task {
            do {
                let results = try await service.searchTracks(term: searchText)
                tracks = results
            } catch {
                print("Could not load tracks: \(error.localizedDescription)")
            }
        }
    }
}
