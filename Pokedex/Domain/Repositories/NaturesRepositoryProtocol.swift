//
//  AnyNaturesRepository.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

protocol NaturesRepositoryProtocol {
    func fetchNatures() async throws -> [Nature]
}
