//
//  SongsModel.swift
//  SearchMusic
//
//  Created by Александр Александров on 19.12.2021.
//

import Foundation

struct SongsModel: Codable {
    let results: [Results]
}

struct Results: Codable {
    let trackName: String?
}
