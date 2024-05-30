//
//  GameDetailRepository.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/17.
//

import Foundation

protocol GameDetailRepositoryType: AnyObject {
    func fetchGameDetail(id: Int, completion: @escaping (GameDetailResult))
}

// MARK: Functions

class GameDetailRepository: GameDetailRepositoryType {
    func fetchGameDetail(id: Int, completion: @escaping (GameDetailResult)) {
        let urlString = Constants.Endpoints.gameDetail + "\(id)"
        URLSession.shared.request(endpoint: urlString, method: .GET, completion: completion)
    }
}
