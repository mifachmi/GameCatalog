//
//  GamesResponse.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation

struct GamesResponse: Codable {
    let count: Int?
    let results: [GameResponse]
}

struct GameResponse: Codable {
    let id: Int
    let name: String?
    let released: String?
    let rating: Double?
    let backgroundImage: String?
    let description: String?
    let alternativeNames: [String]?
    let genres: [GenreResponse]?
    let publishers: [PublisherResponse]?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, released, rating, description, genres, publishers
        case backgroundImage = "background_image"
        case alternativeNames = "alternative_names"
    }
    
    internal init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        
        if let releasedDateString = try container.decodeIfPresent(String.self, forKey: .released) {
            self.released = releasedDateString.formattedDate(
                formFormat: DateConstant.rawDateFormat,
                toFormat: DateConstant.readableDateFormat
            ) ?? StringConstant.invalidDateFormat
        } else {
            self.released = StringConstant.unknown
        }
        
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        self.description = try container.decodeIfPresent(
            String.self,
            forKey: .description
        ) ?? StringConstant.noDescription
        self.genres = try container.decodeIfPresent(
            [GenreResponse].self,
            forKey: .genres
        ) ?? [GenreResponse(name: StringConstant.unknown)]
        self.publishers = try container.decodeIfPresent(
            [PublisherResponse].self,
            forKey: .publishers
        ) ?? [PublisherResponse(name: StringConstant.unknown)]
        self.backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
        self.alternativeNames = try container.decodeIfPresent([String].self, forKey: .alternativeNames) ?? [StringConstant.unknown]
    }
}

struct GenreResponse: Codable {
    let name: String?
}

struct PublisherResponse: Codable {
    let name: String?
}
