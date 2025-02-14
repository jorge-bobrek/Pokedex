//
//  ItemListView.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 13/02/25.
//

import SwiftUI

enum ItemPocket: Int, CaseIterable {
    case items = 1
    case medicine = 2
    case pokeballs = 3
    case machines = 4
    case berries = 5
    case mail = 6
    case battle = 7
    case key = 8
}

struct ItemListView: View {
    @StateObject var viewModel: ItemListViewModel
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    // MARK: - Bag
                    BagView(selected: $viewModel.pocket)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color("bagBackground"))
                    // MARK: - Pocket Item Tabs
                    PocketTabsView(geoWidth: geo.size.width, selected: $viewModel.pocket)
                        .padding(8)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color("headerTop"), Color("headerBottom")]), startPoint: .top, endPoint: .bottom)
                        )
                    // MARK: - Pocket Item List
                    TabView(selection: $viewModel.pocket) {
                        ForEach(ItemPocket.allCases, id: \.self) { icon in
                            ScrollView {
                                LazyVStack(spacing: 0) {
                                    ForEach(viewModel.items.filter { $0.itemPocketId == icon.rawValue }) { item in
                                        ItemView(selected: $viewModel.item, item: item)
                                    }
                                }
                            }
                            .pixelRoundedBorder(cornerRadius: 8, pixelSize: 2, fillColor: Color(.tertiarySystemBackground))
                            .padding(8)
                            .tag(icon.rawValue)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("itemsTop"), Color("itemsBottom")]), startPoint: .top, endPoint: .bottom)
                    )
                    // MARK: - Item info
                    ItemDetailView(selected: $viewModel.item)
                        .frame(maxWidth: .infinity)
                        .background(Color("infoBackground"))
                }
            }
        }
    }
}

struct ItemListView_Previes: PreviewProvider {
    static var previews: some View {
        ItemListView(viewModel: ItemListViewModel())
            .environmentObject(LanguageManager())
    }
}
