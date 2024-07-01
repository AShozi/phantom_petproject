//
//  GameDetailViewModel.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/17.
//

import UIKit

protocol GameDetailViewModelDelegate: AnyObject {
    func gameDetailFetchSuccess(success: Bool)
    func reloadView()
    func show(error: String)
    func setLoading(_ loading: Bool)
}

class GameDetailViewModel {
    private let repository: GameDetailRepositoryType
    private var gameID = 0
    private var gameDetail: GameDetail?
    private var coreDataManager: CoreDataModel
    private weak var delegate: GameDetailViewModelDelegate?
    
    init(repository: GameDetailRepositoryType, delegate: GameDetailViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
        self.coreDataManager = CoreDataModel()
    }
    
    var title: String? {
        gameDetail?.title
    }
    
    var genre: String? {
        gameDetail?.genre
    }
    
    var description: String? {
        gameDetail?.description
    }
    
    var releaseDate: String? {
        gameDetail?.releaseDate
    }
    
    var platform: String? {
        gameDetail?.platform
    }
    
    var thumbnailURL: URL? {
        guard let thumbnail = gameDetail?.thumbnail else { return nil }
        return URL(string: thumbnail)
    }
    
    var gameURL: String? {
        gameDetail?.gameURL
    }
    var isFavorite: Bool {
        guard let gameDetail else { return false }
        return coreDataManager.gameExistsInFavorites(gameDetail: gameDetail)
    }
    
    func fetchGameDetail() {
        delegate?.setLoading(true)
        repository.fetchGameDetail(id: gameID) { [weak self] result in
            switch result {
            case .success(let gameDetail):
                self?.gameDetail = gameDetail
                self?.delegate?.setLoading(false)
                self?.delegate?.gameDetailFetchSuccess(success: true)
            case .failure(let error):
                self?.delegate?.setLoading(false)
                self?.delegate?.gameDetailFetchSuccess(success: false)
                self?.delegate?.show(error: error.localizedDescription)
            }
        }
    }
    
    func updateGameID(gameID: Int) {
        self.gameID = gameID
        fetchGameDetail()
    }
    
    func addToFavorites() {
        guard let gameDetail else { return }
        repository.addToFavorites(gameDetail: gameDetail)
        
    }
}
