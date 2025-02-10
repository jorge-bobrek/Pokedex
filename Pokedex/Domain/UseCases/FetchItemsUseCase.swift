//
//  FetchItemsUseCase.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

class FetchItemsUseCase {
    private let repository: ItemsRepositoryProtocol
    
    init(repository: ItemsRepositoryProtocol = ItemsRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [Item] {
        try await repository.getAllItems()
    }
}
