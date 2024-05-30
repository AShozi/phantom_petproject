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
    func fetchAPIImageCollectionView(completion: @escaping(HomeScreenResult))
    func fetchAPIImageTableView(completion: @escaping(HomeScreenResult))
    func fetchHomeResultsForCollectionView(completion: @escaping (HomeScreenResult))
    func fetchHomeResultsForTableView(completion: @escaping (HomeScreenResult))
    func fetchGameDetailResults(id: Int, completion: @escaping (GameDetailResult))
}

class HomeScreenRepository: HomeScreenRepositoryType {
    func fetchAPIImageCollectionView(completion: @escaping (HomeScreenResult)) {
        URLSession.shared.fetchingAPIImages(URL: Constants.Endpoints.homeForCollectionView) {
            games in completion(.success(games))
        }
    }
    func fetchAPIImageTableView(completion: @escaping (HomeScreenResult)) {
        URLSession.shared.fetchingAPIImages(URL: Constants.Endpoints.homeForCollectionView) {
            games in completion(.success(games))
        }
    }
    func fetchHomeResultsForCollectionView(completion: @escaping (HomeScreenResult)) {
        URLSession.shared.request(endpoint: Constants.Endpoints.homeForCollectionView, method: .GET, completion: completion)
    }
    func fetchHomeResultsForTableView(completion: @escaping (HomeScreenResult)) {
        URLSession.shared.request(endpoint: Constants.Endpoints.homeForTableView, method: .GET, completion: completion)
    }
    func fetchGameDetailResults(id: Int, completion: @escaping (GameDetailResult)) {
        let urlString = Constants.Endpoints.gameDetail + "\(id)"
        URLSession.shared.request(endpoint: urlString, method: .GET, completion: completion)
    }
    func fetchGameDetailResults(id: Int, completion: @escaping (GameDetailResult)) {
        let urlString = Constants.Endpoints.gameDetail + "\(id)"
        URLSession.shared.request(endpoint: urlString, method: .GET, completion: completion)
    }
}
