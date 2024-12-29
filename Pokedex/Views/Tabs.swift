//
//  Tabs.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct Tabs: View {
    var tabs: [Tab]
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs.indices, id: \.self) { row in
                Button {
                    withAnimation {
                        selectedTab = row
                    }
                } label: {
                    VStack(alignment: .center, spacing: 0) {
                        HStack {
                            SafeImage(tabs[row].icon, alter: "Sprites/0")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.primary)
                            DetailText(tabs[row].title, .Detail)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        Rectangle()
                            .fill(selectedTab == row ? Color.primary : Color.clear)
                            .frame(height: 3)
                    }
                }
            }
        }
    }
}

struct Tab {
    var icon: String
    var title: String
}

struct ItemTabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(tabs: [Tab(icon: "Items/00", title: "Tab 1"),
                    Tab(icon: "Items/00", title: "Tab 2"),
                    Tab(icon: "Items/00", title: "Tab 3")],
             selectedTab: .constant(0))
    }
}
