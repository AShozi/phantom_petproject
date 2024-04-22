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
    @IBOutlet weak private var play: UIButton!
    @IBOutlet weak private var genreLabel: UILabel!
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateWith(game: GameModel) {
        titleLabel.text = game.title
        genreLabel.text = game.genre
                if let imageURL = URL(string: game.thumbnail) {
                    icon.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
                } else {
                    icon.image = UIImage(named: "placeholder")
                }
    }
    static func tableViewNib() -> UINib {
        return UINib(nibName: Constants.TableViewIdentifiers.customCellIdentifier, bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
