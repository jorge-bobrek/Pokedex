//
//  ItemDetailView.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 13/02/25.
//

import SwiftUI

struct ItemDetailView: View {
    @Binding var selected: Item?
    
    var body: some View {
        if let selected {
            HStack(spacing: 10) {
                ItemImage(name: selected.name, size: 48)
                    .pixelRoundedBorder(cornerRadius: 8, pixelSize: 2, borderColor: .gray, fillColor: Color.white)
                LanguageText(of: selected.flavor)
                    .detailedText(size: .Text)
                    .foregroundStyle(.white)
                    .shadow(color: .secondary, radius: 1, x: 1, y: 1)
                Spacer()
            }
            .padding(10)
            .frame(height: 80)
        }
    }
}
