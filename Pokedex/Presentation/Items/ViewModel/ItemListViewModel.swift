//
//  ItemListViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

@MainActor
final class ItemListViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var selected: Int = 0
    
    private let itemsRepository = ItemsRepository()
    
    var filteredItems: [Item] {
        let filtered = items
        return filtered.filter {
            $0.itemPocketId == selected + 1
        }
    }
    
    init() {
        Task { [weak self] in
            guard let self else { return }
            await self.getItemList()
        }
    }
    
    func getItemList() async {
        do {
            self.items = try await self.itemsRepository.getAllItems()
        } catch {
            print(error)
        }
    }
}
