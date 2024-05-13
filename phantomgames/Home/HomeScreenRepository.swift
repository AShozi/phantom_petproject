//
//  HomeScreenRepository.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/13.
//

import Foundation
typealias HomeScreenResult = (Result<[Game], APIError>) -> Void

protocol HomeScreenRepositoryType: AnyObject {
    func fetchHomeResults(completion: @escaping(SearchGameResult))
}

class HomeScreenRepository: HomeScreenRepositoryType {
    
    func fetchHomeResults(completion: @escaping (HomeScreenResult)) {
        URLSession.shared.request(endpoint: Constants.Endpoints.search, method: .GET, completion: completion)
    }
}
