//
//  SearchRepsonse.swift
//  MusicApp
//
//  Created by Lera Savchenko on 30.06.24.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track:Decodable {
    var trackName: String
    var artistName: String
    var collectionName: String?
    var artworkUrl100: String?
    var previewUrl: String?
}
