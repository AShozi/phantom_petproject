//
//  CustomTableViewCell.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/18.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var play: UIButton!
    
    @IBOutlet weak var genreLabel: UILabel!
    //    @IBOutlet weak var descriptionLabel: UILabel!
    static let identifier = "TableViewCell"
    
    
    func populateWith(game:GamesModel){
        

        titleLabel.text = game.title
       genreLabel.text = game.genre
        
        
        
    }

   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func tableViewNib() -> UINib{
        
    return UINib(nibName: identifier, bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
