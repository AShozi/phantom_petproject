//
//  CategoryRepository.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/15.
//

#warning(" Will be developed further after concurrency workshop ")

import Foundation

typealias CategoryResult = (String, Result<[Game], APIError>)

protocol CategoryRepositoryType: AnyObject {
    func fetchAPIImage(completion: @escaping (Result<[CategoryResult], APIError>) -> Void)
    func fetchCategory(endpoint: String, completion: @escaping (Result<[Game], APIError>) -> Void)
}
class CategoryRepository: CategoryRepositoryType {
    
    func fetchAPIImage(completion: @escaping (Result<[CategoryResult], APIError>) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var results: [CategoryResult] = []
        
        dispatchGroup.enter()
        fetchCategory(endpoint: Constants.CategoryEndpoints.shooter) { result in
            switch result {
            case let .success(games):
                results.append(("Shooter", .success(games)))
            case let .failure(error):
                results.append(("Shooter", .failure(error)))
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchCategory(endpoint: Constants.CategoryEndpoints.stratergy) { result in
            switch result {
            case let.success(games):
                results.append(("Strategy", .success(games)))
            case let .failure(error):
                results.append(("Strategy", .failure(error)))
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            completion(.success(results))
        }
    }
    func fetchCategory(endpoint: String, completion: @escaping (Result<[Game], APIError>) -> Void) {
        URLSession.shared.request(endpoint: endpoint, method: .GET) { result in
            completion(result)
        }
    }
}
