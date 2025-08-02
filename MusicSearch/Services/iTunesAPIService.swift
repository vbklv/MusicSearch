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
    let baseUrl = URL(string: "https://itunes.apple.com/search")!
    let countryCodeFilters: [String] = ["dk"]
    let searchEntityFilter: String = "musicTrack"

    func searchTracks(term: String) async throws -> [Track] {
        let query = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseUrl)?term=\(query)&country=\(countryCodeFilters.joined(separator: ","))&entity=\(searchEntityFilter)"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, error) = try await URLSession.shared.data(from: url)
        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)

        return apiResponse.results
    }
}

struct APIResponse: Decodable {
    let results: [Track]
}
