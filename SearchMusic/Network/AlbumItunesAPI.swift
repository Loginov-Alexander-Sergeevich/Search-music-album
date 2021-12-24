//
//  AlbumItunesAPI.swift
//  TestJSON
//
//  Created by Александр Александров on 15.12.2021.
//

import Foundation
import Moya

/// Ключи запроса API
enum AlbumItunesAPI {
    case search(path: String)
    case lookup(id: Int)
}

extension AlbumItunesAPI: TargetType {
    // Базовый адрес запроса
    var baseURL: URL {
        guard let url = URL(string: "https://itunes.apple.com/") else { fatalError() }
        return url
    }
    
    // Путь для запроса
    var path: String {
        switch self {
        case .search:
            return "search"
        case .lookup:
            return "lookup"
        }
    }
    
    // Метод запроса
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    // Задача запроса
    var task: Task {
        switch self {
        case .search(let path):
            let params: [String: String] = ["term": path, "atribute": "albumTerm", "entity": "album"]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .lookup(let id):
            let params: [String: Any] = ["id": id, "entity": "song"]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
