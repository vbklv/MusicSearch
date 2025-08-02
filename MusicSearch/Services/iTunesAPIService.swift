//
//  iTunesAPIService.swift
//  MusicSearch
//
//  Created by Vladimir Bakalov on 02/08/2025.
//

import Foundation

protocol iTunesAPIServiceProtocol {
    func searchTracks(term: String) async throws -> [Track]
}

class iTunesAPIService: iTunesAPIServiceProtocol {
    func searchTracks(term: String) async throws -> [Track] {
        return [
            Track(trackName: "Track 1", artistName: "Artist 1"),
            Track(trackName: "Track 2", artistName: "Artist 2")
        ]
    }
}
