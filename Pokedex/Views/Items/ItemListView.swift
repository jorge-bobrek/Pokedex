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
        let tabs = ItemPocket.allCases.map{Tab(icon: nil, title: "\($0)")}
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Tabs(tabs: tabs, selectedTab: $viewModel.selected)
                }
            }.scrollIndicators(.hidden)
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.filteredItems) { item in
                        HStack {
                            SafeImage("Items/\(viewModel.selected == 3 ? 0 : item.id)")
                            DetailLanguageText(of: item.names, .Detail)
                            Spacer()
                            Text("\(item.id)")
                        }
                    }
                }
            }
        }
    }
    
    func SafeImage(_ named: String) -> Image {
        let uiImage = (UIImage(named: named) ?? UIImage(named: "Items/-1"))!
        return Image(uiImage: uiImage)
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
            .environmentObject(LanguageManager())
    }
}
