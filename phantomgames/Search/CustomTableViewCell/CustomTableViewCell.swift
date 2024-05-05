//
//  CustomTableViewCell.swift
//  phantomgame
//
//  Created by Aphiwe Shozi on 2024/04/18.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var icon: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var playButton: UIButton!
    @IBOutlet weak private var genreLabel: UILabel!
    
    // MARK: Variables
    
    private var gameURL: URL?
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.addTarget(self, action: #selector(playButtonTap), for: .touchUpInside)
    }
    
    func populateWith(game: Game) {
        titleLabel.text = game.title
        genreLabel.text = game.genre
                if let imageURL = URL(string: game.thumbnail) {
                    icon.sd_setImage(with: imageURL, placeholderImage: Constants.ImageConstants.placeholder)
                } else {
                    icon.image = Constants.ImageConstants.placeholder
                }
             if let gameURL = URL(string: game.gameURL) {
                 self.gameURL = gameURL
             }
    }
    
    @IBAction func playButtonTap(_ sender: Any) {
        if let gameURL = self.gameURL {
            UIApplication.shared.open(gameURL)
        }
    }
     
    static func tableViewNib() -> UINib {
        return UINib(nibName: Constants.TableViewIdentifiers.customCellIdentifier, bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
