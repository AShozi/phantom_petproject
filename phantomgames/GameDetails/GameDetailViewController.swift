//
//  GameDetailsViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/16.
//
import UIKit

class GameDetailViewController: UIViewController {
    
    @IBOutlet weak private var gameImageView: UIImageView!
    @IBOutlet weak private var gameTitleLabel: UILabel!
    @IBOutlet weak private var gameGenreLabel: UILabel!
    @IBOutlet weak private var gameDescriptionLabel: UILabel!
    @IBOutlet weak private var gameReleaseDate: UILabel!
    @IBOutlet weak private var gamePlatformLabel: UILabel!
    @IBOutlet weak private var gamePlayButton: UIButton!
    
    // MARK:  Variables
    private lazy var gameDetailViewModel = GameDetailViewModel(repository: GameDetailRepository(), delegate: self)
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDetailViewModel.fetchGameDetail()
        updateUI()
    }
    
    func setGameID(gameID: Int) {
        gameDetailViewModel.updateGameID(gameID: gameID)
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {

    func gameDetailFetchSuccess(success: Bool) {
        if success {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    func show(error: String) {
        displayAlert(title: "Error", message: "Failed to fetch game details.", buttonTitle: "Ok")
    }
    private func updateUI() {
        gameTitleLabel.text = gameDetailViewModel.title
        gameGenreLabel.text = gameDetailViewModel.genre
        gameDescriptionLabel.text = gameDetailViewModel.description
        gameReleaseDate.text = gameDetailViewModel.releaseDate
        gamePlatformLabel.text = gameDetailViewModel.platform
        
        if let thumbnailURL = gameDetailViewModel.thumbnailURL {
            gameImageView.downloaded(from: thumbnailURL)
        }
    }
}
