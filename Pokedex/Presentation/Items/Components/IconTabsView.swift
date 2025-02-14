//
//  IconTabs.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 13/02/25.
//

import SwiftUI

struct IconTabsView: View {
    var geoWidth: CGFloat
    @Binding var selectedTab: ItemPocket
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(ItemPocket.allCases, id: \.self) { icon in
                Button {
                    withAnimation {
                        selectedTab = icon
                    }
                } label: {
                    Image(selectedTab == icon ? "Items/\(icon).fill" : "Items/\(icon)")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .opacity(selectedTab == icon ? 1 : 0.5)
                        .animation(nil, value: selectedTab)
                }
            }
        }
    }
}
