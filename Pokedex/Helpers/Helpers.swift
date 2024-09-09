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
    
    func getIndex(url: String) -> Int {
        return Int(url.split(separator: "/").last!)!
    }
    
    func getSprite(for id: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    
    func getSpriteArtwork(for id: Int, canBeShiny: Bool = false) -> String  {
        let isShiny = Int.random(in: 1...4096) == 1 && canBeShiny
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(isShiny ? "shiny/" : "")\(id).png"
    }
}
