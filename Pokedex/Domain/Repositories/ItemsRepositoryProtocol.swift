//
//  AnyItemsRepository.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

protocol ItemsRepositoryProtocol {
    func getAllItems() async throws -> [Item]
}
