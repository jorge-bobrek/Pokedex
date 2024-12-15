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
                            // Image
                            tabs[row].icon
                                .foregroundColor(.primary)
                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                            // Text
                            DetailText(tabs[row].title, .Detail)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .frame(height: 52)
                        // Bar Indicator
                        Rectangle().fill(selectedTab == row ? Color.primary : Color.clear)
                            .frame(height: 3)
                    }
                }
            }
        }
    }
}

struct Tab {
    var icon: Image?
    var title: String
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(tabs: [Tab(icon: Image(systemName: "star.fill"), title: "Tab 1"),
                    Tab(icon: Image(systemName: "star.fill"), title: "Tab 2"),
                    Tab(icon: Image(systemName: "star.fill"), title: "Tab 3")],
             selectedTab: .constant(0))
    }
}
