//
//  Endpoint.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation
import Alamofire

enum GameEndpoint: URLRequestConvertible {
    case getGames(pageSize: Int)
    case getGameDetail(id: Int)
    case searchGames(query: String)
    
    private var baseURL: URL { URL(string: "https://api.rawg.io/api/games")! }
    private var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "RAWG-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'RAWG-Info.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'RAWG-Info.plist'.")
        }
        
        return value
    }
    
    var path: String {
        switch self {
        case .getGames, .searchGames:
            return ""
        case .getGameDetail(let id):
            return "/\(id)"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .getGames(let pageSize):
            return ["key": apiKey, "page_size": pageSize]
        case .getGameDetail:
            return ["key": apiKey]
        case .searchGames(let query):
            return ["key": apiKey, "search": query]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url: URL
        if path.isEmpty {
            url = baseURL
        } else {
            url = baseURL.appendingPathComponent(path)
        }
        var request = URLRequest(url: url)
        request.method = .get
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
