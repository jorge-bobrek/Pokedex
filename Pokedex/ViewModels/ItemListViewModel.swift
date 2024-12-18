//
//  ItemListViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SwiftUI

final class ItemListViewModel: ObservableObject {
    private let itemsManager = PokemonItemsManager()
    
    @Published var items: [Item] = []
    @Published var selected: Int = 0
    
    var filteredItems: [Item] {
        var filtered = items
        return filtered.filter {
            $0.category.itemPocketID == selected + 1
        }
    }
    
    init() {
        self.itemsManager.getItemList { data in
            self.items = data
        }
    }
}

let Icons: [Tab] = [
    Tab(icon: "Items/63", title: "misc"),
    Tab(icon: "Items/17", title: "medicine"),
    Tab(icon: "Items/4", title: "pokeballs"),
    Tab(icon: "Items/0", title: "machines"),
    Tab(icon: "Items/132", title: "berries"),
    Tab(icon: "Items/123", title: "mail"),
    Tab(icon: "Items/56", title: "battle"),
    Tab(icon: "Items/440", title: "key")
]
