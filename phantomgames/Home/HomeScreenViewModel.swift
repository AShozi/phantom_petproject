//
//  HomeScreenViewModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/13.
//


protocol HomeScreenViewModelDelegate: AnyObject {
    func reloadView()
    func reloadCollectionView()
    func reloadTableView()
    func show(error: String)
}

class HomeScreenViewModel {
    
    // MARK: Variables
    
    private var repository: HomeScreenRepositoryType?
    private weak var delegate: HomeScreenViewModelDelegate?
    private(set) var collectionViewGames: [Game] = []
    private(set) var tableViewGames: [Game] = []
    
    init(repository: HomeScreenRepositoryType, delegate: HomeScreenViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate }
    
    // MARK: Computed Properties
    
    
    var collectionViewGamesCount: Int {
        collectionViewGames.count
    }
    
    var tableViewGamesCount: Int {
        tableViewGames.count
    }
    var allGameList: [Game] {
        tableViewGames
    }
 
    // MARK: Functions
    
    func collectionViewGame(atIndex: Int) -> Game? {
        collectionViewGames[atIndex]
    }
    
    func tableViewGame(atIndex: Int) -> Game? {
        tableViewGames[atIndex]
    }
    
    func fetchCollectionViewGames() {
        repository?.fetchHomeResultsForCollectionView { [weak self] result in
            switch result {
            case .success(let games):
                self?.collectionViewGames = games
                self?.delegate?.reloadCollectionView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    
    func fetchTableViewGames() {
        repository?.fetchHomeResultsForTableView { [weak self] result in
            switch result {
            case .success(let games):
                self?.tableViewGames = games
                self?.delegate?.reloadTableView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    
    func fetchGameDetail(id: Int, completion: @escaping (GameDetailResult)) {
        repository?.fetchGameDetailResults(id: id, completion: completion)
    }
}
