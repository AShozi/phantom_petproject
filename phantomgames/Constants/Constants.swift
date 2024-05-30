//
//  Constants.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import UIKit

struct Constants {
    
    struct SegueIdentifiers {
        static let loginSegueIdentifier = "MainSegue"
        static let GameDetailScreenSegue = "GameDetailScreenSegue"
    }
    
    struct TableViewIdentifiers {
        static let customCellIdentifier = "CustomTableViewCell"
        static let customHomeCellIdentifier = "CustomHomeTableViewCell"
    }
    
    struct ImageConstants {
        static let placeholder = UIImage(named: "placeholder")
    }
    
    struct SearchConstants {
        static let searchBarPlaceholder = "Search Game title"
    }
    
    struct Endpoints {
        static let search = "https://www.freetogame.com/api/games?sort-by=alphabetical"
        static let homeForCollectionView = "https://www.freetogame.com/api/games?sort-by=release-date"
        static let homeForTableView = "https://www.freetogame.com/api/games"
        static let gameDetail = "https://www.freetogame.com/api/game?id="
        static let pcGamesURL = "https://www.freetogame.com/api/games?platform=pc"
        static let browserGamesURL = "https://www.freetogame.com/api/games?platform=browser"
    }
    struct CategoryEndpoints {
        static let shooter = "https://www.freetogame.com/api/games/games?category=shooter"
        static let stratergy = "https://www.freetogame.com/api/games/games?category=strategy"
        static let racing = "https://www.freetogame.com/api/games/games?category=racing"
        static let card = "https://www.freetogame.com/api/games/games?category=card"
        static let zombie = "https://www.freetogame.com/api/games/games?category=zombie"
    }
}
