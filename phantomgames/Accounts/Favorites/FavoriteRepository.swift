//
//  FavouriterRepository.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/29.
//
import Foundation

protocol FavoritesRepositoryType {
    func addToFavorites(item: GameDetail)
    func getAllFavorites() -> [GameFavorite]
    func removeFavorite(item: GameFavorite)
    func clearAllFavorites()
}

class FavoritesRepository: FavoritesRepositoryType {
    private let coreDataManager: CoreDataModel

    // MARK: Initialization
    init(coreDataManager: CoreDataModel) {
        self.coreDataManager = coreDataManager
    }

    // MARK: Functions
    func addToFavorites(item: GameDetail) {
        coreDataManager.saveGameToFavorites(gameDetail: item)
    }

    func getAllFavorites() -> [GameFavorite] {
        coreDataManager.fetchAllGameFavorites()
    }

    func removeFavorite(item: GameFavorite) {
        coreDataManager.removeGameFromFavorites(item: item)
    }
    func clearAllFavorites() {
        coreDataManager.clearAllFavorites()
    }
}
