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
            ScrollView(.horizontal) {
                HStack {
                    Tabs(tabs: Icons, selectedTab: $viewModel.selected)
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
            .padding(.horizontal)
        }
    }
    
    func SafeImage(_ named: String) -> Image {
        let uiImage = (UIImage(named: named) ?? UIImage(named: "Items/00"))!
        return Image(uiImage: uiImage)
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
