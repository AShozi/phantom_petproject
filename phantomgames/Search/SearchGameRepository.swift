//
//  SearchGameRepositoryType.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import Foundation
typealias SearchGameResult = (Result<[Game], APIError>) -> Void
typealias TableDetailResult = (Result<GameDetail, APIError>) -> Void

protocol SearchGameRepositoryType: AnyObject {
    func fetchAPIImage(completion: @escaping SearchGameResult)
    func fetchSearchResults(completion: @escaping SearchGameResult)
    func fetchGames(fromURL url: String, completion: @escaping SearchGameResult)
    func fetchTableDetailResults(id: Int, completion: @escaping (TableDetailResult))
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
    
    func fetchTableDetailResults(id: Int, completion: @escaping (TableDetailResult)) {
        let urlString = Constants.Endpoints.gameDetail + "\(id)"
        URLSession.shared.request(endpoint: urlString, method: .GET, completion: completion)
    }
    
}
