//
//  APIHandler.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/05/02.
//

import Foundation

extension URLSession {
    
    func request<T: Codable>(endpoint: String, method: Method, completion: @escaping((Result<T, APIError>) -> Void)) {
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
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.serverError))
                }
                return
            }
            do {
                guard let data else {
                    DispatchQueue.main.async {
                        completion(.failure(.serverError))
                    }
                    return
                }
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(Result.success(object))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(Result.failure(.parsingError))
                }
            }
        }
        dataTask.resume()
    }
    func fetchingAPIImages(URL url: String, completion: @escaping ([Game]) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, _, _ in
            guard let data else { return }
            do {
                let fetchingData =
                try JSONDecoder().decode([Game].self, from: data)
                completion(fetchingData)
            } catch {
            }
            
        }
        dataTask.resume()
    }
}
