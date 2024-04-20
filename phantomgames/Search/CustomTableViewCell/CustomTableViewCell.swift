//
//  CustomTableViewCell.swift
//  phantomgame
//
//  Created by Aphiwe Shozi on 2024/04/18.
//

import UIKit

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
    
    func populateWith(game: GamesModel) {
        titleLabel.text = game.title
        genreLabel.text = game.genre
    }
    
    static func tableViewNib() -> UINib {
        return UINib(nibName: Constants.TableViewIdentifiers.customCellIdentifier, bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpNib(title: String, genre: String) {
        titleLabel.text = title
        genreLabel.text = genre
    }
}
