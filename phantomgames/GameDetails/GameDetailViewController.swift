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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK:  Variables
    private lazy var gameDetailViewModel = GameDetailViewModel(repository: GameDetailRepository(), delegate: self)
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        gameDetailViewModel.fetchGameDetail()
        updateUI()
    }
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    
    func gameDetailFetchSuccess(success: Bool) {
        if success {
            self.updateUI()
        }
    }
    
    func assignGameID(gameID: Int) {
        gameDetailViewModel.updateGameID(gameID: gameID)
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

extension GameDetailViewController: GameDetailViewModelDelegate {
    
    func setLoading(_ loading: Bool) {
        if loading {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
            activityIndicator?.isHidden = true // Hide the loading indicator after data is loaded
        }
    }
    
    func reloadView() {
        activityIndicator?.isHidden = true // Hide the loading indicator after data is loaded
        updateUI()
    }
    
    func show(error: String) {
        displayAlert(title: "Error", message: "Failed to fetch game details.", buttonTitle: "Ok")
    }
    
}
