//
//  MusicSearchTests.swift
//  MusicSearchTests
//
//  Created by Vladimir Bakalov on 02/08/2025.
//

import XCTest
@testable import MusicSearch

@MainActor
final class SearchViewModelTests: XCTestCase {

    func testEmptySearchClearsTracks() {
        // Given a view model with pre-populated tracks
        let viewModel = SearchViewModel()
        viewModel.tracks = [
            Track(
                trackName: "Track 1",
                artistName: "Artist 1",
                artworkUrl100: nil,
                releaseDate: nil,
                collectionName: nil
            )
        ]

        // When searching with an empty query
        viewModel.searchText = ""
        viewModel.search()

        // Then the tracks array should be cleared
        XCTAssertTrue(viewModel.tracks.isEmpty, "Calling search() with an empty query should clear the tracks array")
    }
}
