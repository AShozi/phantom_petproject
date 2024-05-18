//
//  GameDetailsViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/16.
//


import UIKit

class GameDetailViewController: UIViewController {
    
    var gameDetail: GameDetail?
    
    @IBOutlet weak private var gameImageView: UIImageView!
    @IBOutlet weak private var gameTitleLabel: UILabel!
    @IBOutlet weak private var gameGenreLabel: UILabel!
    @IBOutlet weak private var gameDescriptionLabel: UILabel!
    @IBOutlet weak private var gameReleaseDate: UILabel!
    @IBOutlet weak private var gamePlatformLabel: UILabel!
    @IBOutlet weak private var gamePlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayGameDetails()
    }
    private func displayGameDetails() {
        guard let gameDetail = gameDetail else {
            // Handle the case where gameDetail is nil, perhaps by showing an error message or returning early.
            return
        }
        
        gameTitleLabel.text = gameDetail.title
        gameGenreLabel.text = "Genre: \(gameDetail.genre)"
        gameDescriptionLabel.text = gameDetail.description
        gameReleaseDate.text = "Release Date: \(gameDetail.releaseDate)"
        gamePlatformLabel.text = "Platform: \(gameDetail.platform)"
        
        // Assuming you have a function to load the game image asynchronously
        loadGameImage(from: gameDetail.thumbnail)
        
        // Configure your play button as needed
        configurePlayButton()
    }
    
    private func loadGameImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            // Handle invalid URL case
            return
        }
        
        // Assuming you have an extension to load images asynchronously, similar to the one you provided earlier
        gameImageView.downloaded(from: url)
    }
    
    private func configurePlayButton() {
        // Configure your play button appearance or behavior as needed
    }
}
