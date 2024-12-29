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
                    Tabs(tabs: Icons, selectedTab: $viewModel.selected)
                }
            }
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.filteredItems) { item in
                        HStack {
                            SafeImage("Items/\(viewModel.selected == 3 ? 0 : item.id)", alter: "Items/00")
                            DetailLanguageText(of: item.names, .Detail)
                            Spacer()
                            Text("\(item.id)")
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
