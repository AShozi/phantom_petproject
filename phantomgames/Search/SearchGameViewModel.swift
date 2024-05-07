//
//  SearchGameViewModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import UIKit

protocol SearchGameViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class SearchGameViewModel {
    
    // MARK: Variables
    
    private var repository: SearchGameRepositoryType?
    private weak var delegate: SearchGameViewModelDelegate?
    private(set) var allGameList: [Game] = []
    private(set) var filteredGames: [Game] = []
    
    init(repository: SearchGameRepositoryType, delegate: SearchGameViewModelDelegate) { self.repository =
        repository;self.delegate = delegate }
    
    // MARK: Computed Proterties
    
    var gameListCount: Int {
        allGameList.count
    }
    
    // MARK: Functions
    
    func game(atIndex: Int) -> Game? {
        allGameList[atIndex]
    }
    
    func fetchSearchResults() {
        repository?.fetchSearchResults { [weak self] result in
            switch result {
            case .success(let searchResults):
                self?.allGameList = searchResults
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    // MARK: - Search Functions
    func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    func updateSearchController(searchBarText: String?) {
        filteredGames = allGameList
        
        if let searchText = searchBarText?.lowercased(), !searchText.isEmpty {
            filteredGames = allGameList.filter { $0.title.lowercased().contains(searchText) }
        }
        delegate?.reloadView()
    }
}
