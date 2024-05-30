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
    private weak var delegate: GameDetailViewModelDelegate?

    init(repository: GameDetailRepositoryType, delegate: GameDetailViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
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
        guard let gameDetail = gameDetail else { return }
        repository.addToFavorites(gameDetail: gameDetail)
   
    }
}
