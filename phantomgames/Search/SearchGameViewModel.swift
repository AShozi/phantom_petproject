import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class SearchGameViewModel {
    
    private var repository: SearchGameRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private(set) var gameList: [GamesModel] = []
    
    init(repository: SearchGameRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var gameListCount: Int {
        return gameList.count
    }
    
    
    
    func fetchSearchResults() {
        repository?.fetchSearchResults(completion: { [weak self] result in
            switch result {
            case .success(let searchResults):
                self?.gameList = searchResults.results
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}

