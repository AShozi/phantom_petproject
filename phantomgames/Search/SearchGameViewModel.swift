//
//  SearchGameViewModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import Foundation
import UIKit

protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class SearchGameViewModel {
    

    
    private var repository: SearchGameRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private(set) var allGameList: [GameModel] = []
    private(set) var filteredGames: [GameModel] = []
    
    init(repository: SearchGameRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: Computed Proterties
    
    var gameListCount: Int {
        return allGameList.count
    }
    
    // MARK: Functions
    
    func game(atIndex: Int) -> GameModel? {
        return allGameList[atIndex]
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
}

//MARK: - Search Functions
extension SearchGameViewModel{
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredGames = allGameList
        
        if let searchText = searchBarText?.lowercased(), !searchText.isEmpty {
            self.filteredGames = self.allGameList.filter { $0.title.lowercased().contains(searchText) }
            }
        self.delegate?.reloadView()
    }
    }


