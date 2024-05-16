//
//  HomeScreenViewModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/13.
//

import UIKit

protocol HomeScreenViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class HomeScreenViewModel {
    
    // MARK: Variables
    
    private var repository: HomeScreenRepositoryType?
    private weak var delegate: HomeScreenViewModelDelegate?
    private(set) var allGameList: [Game] = []
    
    init(repository: HomeScreenRepositoryType, delegate: HomeScreenViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate }
    
    // MARK: Computed Properties
    
    var gameListCount: Int {
        allGameList.count
    }
    
    // MARK: Functions
    
    func game(atIndex: Int) -> Game? {
        allGameList[atIndex]
    }
    func fetchHomeResults() {
        repository?.fetchHomeResults { [weak self] result in
            switch result {
            case .success(let homeResults):
                self?.allGameList = homeResults
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
        
    }
}
