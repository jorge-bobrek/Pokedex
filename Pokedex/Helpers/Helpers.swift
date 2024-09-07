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
    
    func getLanguage(names: [LanguageModel]?, language: Language) -> String {
        return names?.first(where: { $0.id == language.rawValue })?.name ?? ""
    }
    
    func sortMoves(_ movements: Movements?, filterMethod: Int) async -> [String: [Move]]? {
        guard let moves = movements?.moves else { return nil }
        
        return await Task.detached(priority: .userInitiated) {
            return moves.reduce(into: [String: [Move]]()) { result, move in
                let method = move.method
                
                // Filtrar solo los métodos que coinciden con el 'filterMethod'
                guard method == filterMethod else { return }
                
                let name = Bundle.main.getLanguage(names: move.names?.names, language: .spanish)
                
                // Utilizamos 'default' para evitar comprobar si existen o no
                result[name, default: []].append(move)
            }
        }.value
    }
    
}

enum Language: Int {
    case jaHrkt = 1
    case roomaji = 2
    case korean = 3
    case zhHant = 4
    case french = 5
    case deutsch = 6
    case spanish = 7
    case italian = 8
    case english = 9
    case japanese = 10
    case zhHans = 11
}
