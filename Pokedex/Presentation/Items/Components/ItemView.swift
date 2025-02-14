//
//  ItemView.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 13/02/25.
//

import SwiftUI

struct ItemView: View {
    @Binding var selected: Item?
    let item: Item
    
    var body: some View {
        HStack {
            PokemonImage(name: item.name, size: 32, endpoint: .item)
            LanguageText(of: item.names)
                .detailedText(size: .Detail)
            Spacer()
        }
        .padding(.horizontal, 4)
        .pixelRoundedBorder(cornerRadius: 4, pixelSize: 3, borderColor: selected?.id == item.id ? .red : .clear)
        .padding(2)
        .contentShape(Rectangle())
        .onTapGesture {
            selected = item
        }
    }
}
