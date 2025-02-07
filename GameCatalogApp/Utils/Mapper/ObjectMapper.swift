//
//  ObjectMapper.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation

final class ObjectMapper {
    
    static func mapGameResponseToDomain(input gameResponse: [GameResponse]) -> [GameModel] {
        return gameResponse.map { result in
            return GameModel(
                id: result.id,
                name: result.name ?? "",
                released: result.released ?? "",
                rating: result.rating ?? 0.0,
                backgroundImage: result.backgroundImage ?? "",
                description: result.description ?? "",
                alternativeNames: result.alternativeNames ?? [],
                genres: result.genres?.map { Genre(name: $0.name ?? "") } ?? [Genre(name: "")],
                publishers: result.publishers?.map { Publisher(name: $0.name ?? "") } ?? [Publisher(name: "")]
            )
        }
    }
    
    static func mapGameResponseToDomain(input gameResponse: GameResponse) -> GameModel {
        return GameModel(
            id: gameResponse.id,
            name: gameResponse.name ?? "",
            released: gameResponse.released ?? "",
            rating: gameResponse.rating ?? 0.0,
            backgroundImage: gameResponse.backgroundImage ?? "",
            description: gameResponse.description ?? "",
            alternativeNames: gameResponse.alternativeNames ?? [],
            genres: gameResponse.genres?.map { Genre(name: $0.name ?? "") } ?? [Genre(name: "")],
            publishers: gameResponse.publishers?.map { Publisher(name: $0.name ?? "") } ?? [Publisher(name: "")]
        )
    }
    
    static func mapGameResponseToEntity(input gameResponse: [GameResponse]) -> [GameEntity] {
        return gameResponse.map { result in
            let newGame = GameEntity()
            newGame.id = Int32(result.id)
            newGame.name = result.name ?? ""
            newGame.released = result.released ?? ""
            newGame.rating = result.rating ?? 0.0
            newGame.backgroundImage = result.backgroundImage ?? ""
            newGame.descriptionGame = result.description ?? ""
            newGame.alternativeNames = result.alternativeNames ?? []
            newGame.genres = result.genres?.map { $0.name ?? "" } ?? []
            newGame.publishers = result.publishers?.map { $0.name ?? "" } ?? []
            return newGame
        }
    }
    
    static func mapGameEntityToDomain(input gameEntity: [GameEntity]) -> [GameModel] {
        return gameEntity.map { result in
            return GameModel(
                id: Int(result.id),
                name: result.name ?? "",
                released: result.released ?? "",
                rating: result.rating,
                backgroundImage: result.backgroundImage ?? "",
                description: result.descriptionGame ?? "",
                alternativeNames: result.alternativeNames ?? [],
                genres: (result.genres)?.map { Genre(name: $0) } ?? [Genre(name: "")],
                publishers: (result.publishers)?.map { Publisher(name: $0) } ?? [Publisher(name: "")]
            )
        }
    }
}
