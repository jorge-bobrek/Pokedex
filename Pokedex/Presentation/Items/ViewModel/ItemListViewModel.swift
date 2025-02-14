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
    @Published var pocket: ItemPocket = .items
    @Published var item: Item?
    
    private let itemsRepository = ItemsRepository()
    
    init() {
        Task { [weak self] in
            guard let self else { return }
            await self.getItemList()
        }
    }
    
    func getItemList() async {
        do {
            let list = try await self.itemsRepository.getAllItems()
            self.items = list
            self.item = list.first(where: {$0.itemPocketId == 1})
        } catch {
            print(error)
        }
    }
}
