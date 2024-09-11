//
//  JSONManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 10/09/24.
//

import Foundation

final class JSONManager {
    
    static let shared = JSONManager()
    
    private init() { }
    
    /// Carga un archivo JSON y lo decodifica en el tipo especificado
    /// - Parameters:
    ///   - fileName: Nombre del archivo (sin extensión)
    ///   - type: El tipo de datos esperado (debe implementar `Decodable`)
    ///   - completion: Bloque que devuelve el resultado decodificado o un error
    func load<T: Decodable>(fileName: String, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                DispatchQueue.main.async {
                    completion(.failure(JSONError.fileNotFound))
                }
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
    }
    
    enum JSONError: Error, LocalizedError {
        case fileNotFound
        
        var errorDescription: String? {
            switch self {
            case .fileNotFound:
                return "El archivo JSON no fue encontrado en el bundle."
            }
        }
    }
}
