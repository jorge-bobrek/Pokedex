//
//  NetworkService.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 29/01/25.
//

import Foundation

struct NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()

    private init() {}
    
    func fetchData<T: Decodable>(endpoint: String) async throws(NetworkError) -> T {
        do {
            // Build URL
            let baseURLString = "http://149.130.182.84:26999/\(endpoint)"
            
            guard let url = URL(string: baseURLString) else {
                throw NetworkError.invalidURL(urlString: baseURLString)
            }
            
            // Perform Request
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate Status Code
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(
                    statusCode: httpResponse.statusCode,
                    message: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                )
            }
            return try JSONDecoder().decode(T.self, from: data)
            
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(
                type: String(describing: T.self),
                innerError: error
            )
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet:
                throw NetworkError.noInternetConnection
            case .timedOut:
                throw NetworkError.timeout
            default:
                throw NetworkError.networkError(code: error.code.rawValue, description: error.localizedDescription)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknownError(description: error.localizedDescription)
        }
    }
}

