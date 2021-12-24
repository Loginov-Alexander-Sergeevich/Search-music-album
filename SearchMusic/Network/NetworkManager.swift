//
//  NetworkManager.swift
//  MusicTest
//
//  Created by Александр Александров on 11.12.2021.
//

import Foundation
import UIKit
import Moya

class NetworkManager {

    let provider = MoyaProvider<AlbumItunesAPI>()
    
    
    func getAlbum(nameAlbum: String/* нужно замыкание с reloadData таблици */) /*-> [ResultsRequestAlbums]?*/ {
        var resultsRequestAlbums: [ResultsAlbums] = []
//
//        return provider.request(.search(path: nameAlbum)) { result in
//
//            switch result {
//            case .success(let response):
//                do {
//                   let resultss = try response.map(RequestAlbums.self).results!
//                    resultsRequestAlbums.append(contentsOf: resultss)
//
//                } catch {
//
//                }
//            case .failure(_): break
//
//            }
//        }
        
    }
}

