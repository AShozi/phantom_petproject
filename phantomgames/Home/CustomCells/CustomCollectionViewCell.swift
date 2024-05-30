//
//  CustomCollectionViewCell.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/13.
//
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    // MARK: IBOutlets
    
    @IBOutlet weak private var apiImage: UIImageView!
    @IBOutlet weak private var gametitle: UILabel!
    
    // MARK: Variables
    
    private var gameURL: URL?
    
    // MARK: Functions
    
    func configCellWith(game:Game){
        gametitle.text = game.title
        if !game.thumbnail.isEmpty {
            apiImage.downloaded(from: game.thumbnail)
        } else {
            apiImage.image = Constants.ImageConstants.placeholder
        }
    }
}
