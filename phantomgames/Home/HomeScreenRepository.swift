//
//  HomeScreenRepository.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/13.
//
import Foundation
typealias HomeScreenResult = (Result<[Game], APIError>) -> Void
typealias GameDetailResult = (Result<GameDetail, APIError>) -> Void

protocol HomeScreenRepositoryType: AnyObject {
    func fetchAPIImage(completion: @escaping(HomeScreenResult))
    func fetchHomeResults(completion: @escaping (HomeScreenResult))
    func fetchGameDetailResults(id: Int, completion: @escaping (GameDetailResult))
}

class HomeScreenRepository: HomeScreenRepositoryType {
    func fetchAPIImage(completion: @escaping (HomeScreenResult)) {
        URLSession.shared.fetchingAPIImages(URL: Constants.Endpoints.search) {
            games in completion(.success(games))
        }
    }
    func fetchHomeResults(completion: @escaping (HomeScreenResult)) {
        URLSession.shared.request(endpoint: Constants.Endpoints.search, method: .GET, completion: completion)
    }
    func fetchGameDetailResults(id: Int, completion: @escaping (GameDetailResult))  -> Void {
        let urlString = Constants.Endpoints.gameDetail(id: id)
        URLSession.shared.request(endpoint: urlString, method: .GET, completion: completion)
    }
}
