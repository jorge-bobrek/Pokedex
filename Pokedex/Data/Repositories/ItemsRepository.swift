//
//  ItemsRepository.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

class ItemsRepository: ItemsRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func getAllItems() async throws -> [Item] {
        return try await networkService.fetchData(endpoint: "items")
    }
}
