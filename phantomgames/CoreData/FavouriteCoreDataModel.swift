//
//  CoreDataModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/29.
//
import UIKit
import CoreData

// MARK: Enum

enum CoreDataError: Error {
    case noContext
}

// MARK: Protocol

protocol CoreDataModelDelegate: AnyObject {
    func favoritesUpdated()
}

// MARK: CoreData Class

class CoreDataModel {
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    // MARK: Functions
    
    func fetchAllGameFavorites() -> [GameFavorite] {
        do {
            guard let context else { throw CoreDataError.noContext }
            return try context.fetch(GameFavorite.fetchRequest())
        } catch {
            print("Error fetching game favorites: \(error)")
            return []
        }
    }
    
    func saveGameToFavorites(gameDetail: GameDetail) {
        do {
            guard let context else { throw CoreDataError.noContext }
            let fetchRequest: NSFetchRequest<GameFavorite> = GameFavorite.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title = %@", gameDetail.title)
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let newFavorite = GameFavorite(context: context)
                newFavorite.title = gameDetail.title
                newFavorite.icon = gameDetail.thumbnail
                newFavorite.genre = gameDetail.genre
                newFavorite.gameDescription = gameDetail.description
                newFavorite.releaseDate = gameDetail.releaseDate
                newFavorite.platform = gameDetail.platform
                newFavorite.gameURL = URL(string: gameDetail.gameURL)
                
                try context.save()
            } else {
                print("Game already exists in favorites")
            }
        } catch {
            print("Error saving game to favorites: \(error)")
        }
    }
    
    func removeGameFromFavorites(item: GameFavorite) {
        guard let context else { return }
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("Error removing game from favorites: \(error)")
        }
    }
    
    func clearAllFavorites() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = GameFavorite.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            guard let context else { throw CoreDataError.noContext }
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            print("Error clearing all favorites: \(error)")
        }
    }
    func gameExistsInFavorites(gameDetail: GameDetail) -> Bool {
        let fetchRequest: NSFetchRequest<GameFavorite> = GameFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title = %@", gameDetail.title)
        do {
            guard let context else { return false }
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Error checking game in favorites: \(error)")
            return false
        }
    }
}
