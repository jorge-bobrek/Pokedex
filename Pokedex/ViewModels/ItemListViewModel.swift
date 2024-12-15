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
    
    @EnvironmentObject var languageManager: LanguageManager
    
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
