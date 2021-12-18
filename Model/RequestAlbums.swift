//
//  RequestAlbums.swift
//  TestJSON
//
//  Created by Александр Александров on 15.12.2021.
//

import Foundation

// ResponseTheRequestAlbumsInITunes

//struct RequestAlbums: Codable {
//    var results: [ResultsRequestAlbums]?
//}
//
//struct ResultsRequestAlbums: Codable {
//    let artistName: String?
//    let collectionName: String?
//    let artworkUrl100: String?
//    let trackCount: Int?
//    let releaseDate: String?
//}

// MARK: - Welcome
struct RequestAlbums: Codable {
    let results: [ResultsRequestAlbums]?
}

// MARK: - Result
struct ResultsRequestAlbums: Codable {
    let artistName: String?
    let collectionName: String?
    let artworkUrl100: String?
    let trackCount: Int?
    let releaseDate: String?
}
