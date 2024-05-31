//
//  AccountsViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/29.
//

import UIKit

class AccountsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var favouriteTableView: UITableView!
    private var favoriteItems: [GameFavorite] = []
    
    // MARK: Variables
    private lazy var favoritesViewModel = FavoritesViewModel(favoritesRepository: FavoritesRepository(coreDataManager: CoreDataModel()))
    
    @IBAction private func resetFavorites(_ sender: UIButton) {
        favoritesViewModel.clearAllFavorites()
        fetchAndDisplayFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        fetchAndDisplayFavorites()
    }
    
    // MARK: Private Methods
    
    private func fetchAndDisplayFavorites() {
        favoriteItems = favoritesViewModel.fetchAndDisplayFavorites()
        favouriteTableView.reloadData()
    }
    
    private func setupTableView() {
        
        favouriteTableView.register(FavoriteCustomTableViewCell.favoritetableViewNib(),
                                    forCellReuseIdentifier: Constants.TableViewIdentifiers.customFavoriteCellIdentifier)
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        
    }
}

// MARK: UITableView Delegate

extension AccountsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib(nibName: "FavoriteCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell",
                                                       for: indexPath) as? FavoriteCustomTableViewCell else {
            return UITableViewCell()
        }
        let game = favoriteItems[indexPath.row]
        let deleteHandler = { [weak self] in
            guard let self = self else { return }
            let itemToDelete = self.favoriteItems[indexPath.row]
            self.favoritesViewModel.removeFavorite(item: itemToDelete)
            self.favoriteItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        cell.configure(with: game.title, item: game, gameURL: game.gameURL, deleteHandler: deleteHandler)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = favoriteItems[indexPath.row]
            favoritesViewModel.removeFavorite(item: itemToDelete)
            favoriteItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
