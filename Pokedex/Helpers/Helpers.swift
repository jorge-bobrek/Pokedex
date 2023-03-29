//
//  Helpers.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation

extension Bundle {
    func fetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping (T) -> (), failure: @escaping (Error) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    failure(error)
                }
                return
            }
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(serverData)
            } catch {
                failure(error)
            }
        }
        .resume()
    }
}

enum Language: String {
    case spanish = "es"
    case english = "en"
    case japanese = "ja-Hrkt"
}
