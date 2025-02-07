//
//  GameModel.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 25/01/25.
//

import Foundation

struct GameModel {
    let id: Int
    let name: String?
    let released: String?
    let rating: Double?
    let backgroundImage: String?
    let description: String?
    let alternativeNames: [String]?
    let genres: [Genre]?
    let publishers: [Publisher]?
}

struct Genre {
    let name: String?
}

struct Publisher {
    let name: String?
}
