//
//  Imageview.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import Foundation
import UIKit

extension UIImageView {
    func load(urlString: String) {
        if let safeURL = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: safeURL) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
