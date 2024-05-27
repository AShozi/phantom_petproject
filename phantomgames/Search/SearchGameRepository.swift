//
//  SearchGameRepositoryType.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import Foundation
typealias SearchGameResult = (Result<[Game], APIError>) -> Void

protocol SearchGameRepositoryType: AnyObject {
    func fetchAPIImage(completion: @escaping SearchGameResult)
    func fetchSearchResults(completion: @escaping SearchGameResult)
    func fetchGames(fromURL url: String, completion: @escaping SearchGameResult)
}

class SearchGameRepository: SearchGameRepositoryType {
    func fetchAPIImage(completion: @escaping SearchGameResult) {
        URLSession.shared.fetchingAPIImages(URL: Constants.Endpoints.search) {games in
            completion(.success(games))
        }
    }
    func fetchSearchResults(completion: @escaping SearchGameResult) {
        URLSession.shared.request(endpoint: Constants.Endpoints.search, method: .GET, completion: completion)
    }
    func fetchGames(fromURL url: String, completion: @escaping SearchGameResult) {
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
}
