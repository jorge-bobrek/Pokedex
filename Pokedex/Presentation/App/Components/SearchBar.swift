//
//  SearchBar.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 11/02/25.
//

import SwiftUI
    
struct SearchBar: View {
    @Binding var searchText: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.primary)
                TextField("Search Pokémon", text: $searchText)
                    .detailedText(size: .Detail)
                    .focused($isFocused)
                    .autocorrectionDisabled()
                if !searchText.isEmpty {
                    Button {
                        searchText.removeAll()
                    } label: {
                        Image(systemName: "x.circle.fill")
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .borderBackground(cornerRadius: 18)
            if isFocused {
                Button {
                    isFocused.toggle()
                } label: {
                    Text("Cancel")
                        .detailedText(size: .Typing)
                }
            }
        }
        .padding(.vertical, 1)
        .animation(.bouncy(duration: 0.3, extraBounce: 0.2), value: isFocused)
    }
}
