//
//  FetchNaturesUseCase.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

class FetchNaturesUseCase {
    private let repository: NaturesRepositoryProtocol
    
    init(repository: NaturesRepositoryProtocol = NaturesRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [Nature] {
        try await repository.fetchNatures()
    }
}
