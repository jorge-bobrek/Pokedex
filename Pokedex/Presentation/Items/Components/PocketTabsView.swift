//
//  PocketTabsView.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 13/02/25.
//

import SwiftUI

struct PocketTabsView: View {
    var geoWidth: CGFloat
    @Binding var selected: ItemPocket
    
    var body: some View {
        VStack {
            IconTabsView(geoWidth: geoWidth, selectedTab: $selected)
            Text("\(selected)")
                .detailedText(size: .Info)
                .frame(maxWidth: .infinity)
                .pixelRoundedBorder(cornerRadius: 4, pixelSize: 2, fillColor: Color(.tertiarySystemBackground))
                .animation(nil, value: selected)
        }
    }
}
