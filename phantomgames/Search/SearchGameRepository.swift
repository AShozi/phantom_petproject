
//
//  SearchGameRepositoryType.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import Foundation

typealias SearchGameResult = (Result<[GameModel], APIError>) -> Void

protocol SearchGameRepositoryType: AnyObject {
    func fetchSearchResults(completion: @escaping(SearchGameResult))
}

class SearchGameRepository: SearchGameRepositoryType {
    
    func fetchSearchResults(completion: @escaping (SearchGameResult)) {
        request(endpoint: "https://www.freetogame.com/api/games", method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(endpoint: String, method: Method, completion: @escaping((Result<T, APIError>) -> Void)) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.internalError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        call(with: request, completion: completion)
    }
    private func call<T: Codable>(with request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async() {
                    completion(.failure(.serverError))
                }
                return
            }
            do {
                guard let data = data else {
                    DispatchQueue.main.async() {
                        completion(.failure(.serverError))
                    }
                    return
                }
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async() {
                    completion(Result.success(object))
                }
            } catch {
                DispatchQueue.main.async() {
                    completion(Result.failure(.parsingError))
                }
            }
        }
        dataTask.resume()
    }
}
