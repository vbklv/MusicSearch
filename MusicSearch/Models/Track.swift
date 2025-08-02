//
//  Track.swift
//  MusicSearch
//
//  Created by Vladimir Bakalov on 02/08/2025.
//

import Foundation

struct Track: Decodable, Identifiable {
    let id = UUID()
    let trackName: String?
    let artistName: String?

    enum CodingKeys: String, CodingKey {
        case trackName, artistName
    }
}
