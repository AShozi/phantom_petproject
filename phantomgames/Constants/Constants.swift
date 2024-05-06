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
        static let pageScreenSegue = "pageScreenSegue"
    }
    struct TableViewIdentifiers {
        static let customCellIdentifier = "CustomTableViewCell"
    }
    struct ImageConstants {
        static let placeholder = UIImage(named: "placeholder")
    }
    struct SearchConstants {
        static let searchBarPlaceholder = "Search Game title"
    }
    struct Endpoints {
        static let search = "https://www.freetogame.com/api/games"
    }
}
