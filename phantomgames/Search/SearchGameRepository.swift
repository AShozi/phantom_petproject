
//
//  SearchGameRepositoryType.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import Foundation
typealias SearchGameResult = (Result<[Game], APIError>) -> Void

protocol SearchGameRepositoryType: AnyObject {
    func fetchSearchResults(completion: @escaping(SearchGameResult))
}

class SearchGameRepository: SearchGameRepositoryType {
    
    func fetchSearchResults(completion: @escaping (SearchGameResult)) {
        URLSession.shared.request(endpoint:Constants.Endpoints.search, method: .GET, completion: completion)
    }
}
