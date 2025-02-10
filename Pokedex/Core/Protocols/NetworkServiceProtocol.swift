//
//  AnyNetworkService.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/01/25.
//

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(endpoint: String) async throws -> T
}
