//
//  CustomHomeTableViewCell.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/14.
//

import UIKit

class CustomHomeTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var icon: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var playButton: UIButton!
    
    // MARK: Variables
    
    private var gameURL: URL?
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    func populateWith(game: Game) {
        titleLabel.text = game.title
        if !game.thumbnail.isEmpty {
            icon.downloaded(from: game.thumbnail)
        } else {
            icon.image = Constants.ImageConstants.placeholder
        }
        if let gameURL = URL(string: game.gameURL) {
            self.gameURL = gameURL
        }
    }
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        if let gameURL = self.gameURL {
            UIApplication.shared.open(gameURL)
        }
    }
    
    static func hometableViewNib() -> UINib {
        UINib(nibName: Constants.TableViewIdentifiers.customHomeCellIdentifier, bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
