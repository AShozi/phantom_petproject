//
//  FavouritesViewModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/29.
//

import Foundation

class FavoritesViewModel {

    // MARK: Variables
    private let favoritesRepository: FavoritesRepositoryType

    // MARK: Computed Variables
    var savedFavoritesCount: Int {
        favoritesRepository.getAllFavorites().count
    }

    // MARK:  Initializer
    init(favoritesRepository: FavoritesRepositoryType) {
        self.favoritesRepository = favoritesRepository
    }

    // MARK: Functions
    func fetchAndDisplayFavorites() -> [GameFavorite] {
        favoritesRepository.getAllFavorites()
    }

    func addToFavorites(item: GameDetail) {
        favoritesRepository.addToFavorites(item: item)
    }

    func removeFavorite(item: GameFavorite) {
        favoritesRepository.removeFavorite(item: item)
    }
    func clearAllFavorites() {
        favoritesRepository.clearAllFavorites()
    }
}
