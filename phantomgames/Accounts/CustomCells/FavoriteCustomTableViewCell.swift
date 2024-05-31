//
//  FavoriteCustomTableViewCell.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/30.
//

import UIKit

class FavoriteCustomTableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    private lazy var favoritesViewModel = FavoritesViewModel(favoritesRepository: FavoritesRepository(coreDataManager: CoreDataModel()))
    
    private var deleteHandler: (() -> Void)?
    private var favoriteItem: GameFavorite?
    private var gameURL: URL?
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var favoriteGameTitle: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet weak var gameButton: UIButton!
    
    // MARK: Function
    
    func configure(with title: String?, item: GameFavorite, gameURL: URL?, deleteHandler: (() -> Void)?) {
        favoriteGameTitle.text = title
        favoriteItem = item
        self.gameURL = gameURL
        self.deleteHandler = deleteHandler
        
    }
    
    // MARK: IBAction
    
    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
        deleteHandler?()
    }
    
    @IBAction func gameButtonTapped(_ sender: UIButton) {
        if let gameURL = self.gameURL {
            UIApplication.shared.open(gameURL)
        }
    }
    static func favoritetableViewNib() -> UINib {
        UINib(nibName: Constants.TableViewIdentifiers.customFavoriteCellIdentifier, bundle: nil)
    }
}
