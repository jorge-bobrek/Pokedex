//
//  Tabs.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct Tabs<Content: View>: View {
    var tabs: [Content]
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs.indices, id: \.self) { row in
                Button {
                    withAnimation(.linear) {
                        selectedTab = row
                    }
                } label: {
                    VStack(alignment: .center, spacing: 0) {
                        tabs[row]
                        Rectangle()
                            .fill(selectedTab == row ? Color.primary : Color.clear)
                            .frame(height: 3)
                    }
                }
            }
        }
    }
}

struct TabContent: View {
    let iconName: String
    let title: String
    
    var body: some View {
        HStack {
            Image(iconName)
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundColor(.primary)
            Text(title)
                .detailedText(size: .Detail)
        }
        .foregroundStyle(.black)
        .padding()
    }
}
