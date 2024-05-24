//
//  GameDetailModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/18.
//

import Foundation

struct GameDetail: Codable {
    let gameID: Int
    let title: String
    let description: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let thumbnail: String
    let gameURL: String
    
    enum CodingKeys: String, CodingKey {
        case title, description, genre, platform, publisher, developer
        case gameID = "id"
        case releaseDate = "release_date"
        case thumbnail, gameURL = "game_url"
    }
}
