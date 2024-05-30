//
//  SearchGameViewModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class SearchGameViewModel {
    
    // MARK: Variables
    
    var gamesURL: String?
    private var repository: SearchGameRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var allGameList: [Game] = []
    private var filteredGames: [Game] = []
     
    init(repository: SearchGameRepositoryType, delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate }
  
    // MARK: Computed Proterties
    
    var gameListCount: Int {
        allGameList.count
    }
    
    var filteredGamesCount: Int {
        filteredGames.count
    }
    
    // MARK: Functions
    
    func game(atIndex: Int) -> Game? {
        allGameList[atIndex]
    }
    
    func setGameUrl(gamesURL: String){
        self.gamesURL = gamesURL
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
    
    func fetchSearchResults(fromURL url: String) {
        repository?.fetchGames(fromURL: url) { [weak self] result in
            switch result {
            case .success(let searchResults):
                self?.allGameList = searchResults
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    
    // MARK: Search Functions
    
    func filteredGame(index: Int, isSearchActive: Bool, searchText: String?) -> Game {
        if isSearchActive {
            return filteredGames[index]
        }
        return allGameList[index]
    }
    
    func updateSearchController(searchBarText: String?) {
        filteredGames = allGameList
        
        if let searchText = searchBarText?.lowercased(), !searchText.isEmpty {
            filteredGames = allGameList.filter { $0.title.lowercased().contains(searchText) }
        }
        delegate?.reloadView()
    }
}
