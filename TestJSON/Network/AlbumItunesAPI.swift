//
//  AlbumItunesAPI.swift
//  TestJSON
//
//  Created by Александр Александров on 15.12.2021.
//

import Foundation
import Moya

enum AlbumItunesAPI {
    case search(path: String)
}

extension AlbumItunesAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://itunes.apple.com/") else { fatalError() }
        return url
    }
    
    var path: String {
        
        
        return "search"
        
        
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let path):
            let params: [String: String] = ["term": path, "atribute": "albumTerm", "entity": "album"]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
