//
//  SearchGameModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import Foundation

struct GamesModel: Codable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameURL: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let freetogameProfileURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail
        case shortDescription = "short_description"
        case gameURL = "game_url"
        case genre, platform, publisher, developer
        case releaseDate = "release_date"
        case freetogameProfileURL = "freetogame_profile_url"
    }
}
