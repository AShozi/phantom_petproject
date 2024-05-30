//
//  GameDetailRepository.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/17.
//

import Foundation

protocol GameDetailRepositoryType: AnyObject {
    func fetchGameDetail(id: Int, completion: @escaping (Result<GameDetail, APIError>) -> Void)
    func addToFavorites(gameDetail: GameDetail)
}

class GameDetailRepository: GameDetailRepositoryType {

    
    private let coreDataManager: CoreDataModel

    // MARK: - Initializer
    init(coreDataManager: CoreDataModel) {
        self.coreDataManager = coreDataManager
    }

    // MARK: - Functions
    func fetchGameDetail(id: Int, completion: @escaping (Result<GameDetail, APIError>) -> Void) {
        let urlString = Constants.Endpoints.gameDetail + "\(id)"
        URLSession.shared.request(endpoint: urlString, method: .GET, completion: completion)
    }

    func addToFavorites(gameDetail: GameDetail) {
        coreDataManager.saveGameToFavorites(gameDetail: gameDetail)
    }
}
