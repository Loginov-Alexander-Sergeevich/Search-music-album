//
//  AlbumsModel.swift
//  TestJSON
//
//  Created by Александр Логинов on 15.12.2021.
//

import Foundation

struct Albums: Codable {
    let results: [ResultsAlbums]?
}

struct ResultsAlbums: Codable {
    let artistName: String?
    let collectionName: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let trackCount: Int?
    let releaseDate: String?
    let collectionId: Int
}
