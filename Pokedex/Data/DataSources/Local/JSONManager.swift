//
//  JSONManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 10/09/24.
//

import Foundation

protocol AnyJSONManager {
    func load<T: Decodable>(fileName: String, as type: T.Type) async throws -> T
}

final class JSONManager: AnyJSONManager {
    static let shared = JSONManager()
    
    private init() { }
    
    /// Carga un archivo JSON y lo decodifica en el tipo especificado
    /// - Parameters:
    ///   - fileName: Nombre del archivo (sin extensión)
    ///   - type: El tipo de datos esperado (debe implementar `Decodable`)
    func load<T: Decodable>(fileName: String, as type: T.Type) async throws -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw JSONError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw JSONError.decodingFailed(
                type: String(describing: T.self),
                innerError: error
            )
        } catch {
            throw JSONError.unknownError(description: error.localizedDescription)
        }
    }
    
    enum JSONError: Error, LocalizedError {
        case fileNotFound
        case decodingFailed(type: String, innerError: DecodingError)
        case unknownError(description: String)
        
        var localizedDescription: String {
            switch self {
            case .fileNotFound:
                return "JSON file not found in bundle."
            case .decodingFailed(let type, let innerError):
                return "Failed to decode \(type): \(innerError.localizedDescription)"
            case .unknownError(let description):
                return "Unknown error: \(description)"
            }
        }
    }
}
