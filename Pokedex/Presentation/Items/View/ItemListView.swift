//
//  ItemListView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct ItemListView: View {
    @StateObject var viewModel = ItemListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    let icons: [String] = ["items", "medicine", "pokeballs", "machines", "berries", "mail", "battle", "key"]
                    Tabs(tabs: icons.map { icon in
                        TabContent(iconName: icon, title: icon)
                    }, selectedTab: $viewModel.selected)
                }
            }
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.filteredItems) { item in
                        HStack {
                            PokemonImage(name: item.name, size: 32, endpoint: .item)
                            LanguageText(of: item.names)
                                .detailedText(size: .Detail)
                            Spacer()
                            InfoText("\(item.id)")
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
