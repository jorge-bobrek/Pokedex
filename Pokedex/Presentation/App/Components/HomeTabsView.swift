//
//  HomeTabsView.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 14/02/25.
//

import SwiftUI

struct HomeTabsView: View {
    @ScaledMetric var tabSpace = 20
    var tabs: [HomeTab]
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: tabSpace) {
            ForEach(0 ..< tabs.count, id: \.self) { row in
                Button {
                    withAnimation {
                        selectedTab = row
                    }
                } label: {
                    HStack(spacing: 2) {
                        // Image
                        AnyView(tabs[row].icon)
                        // Text
                        Text(tabs[row].title)
                            .detailedText(size: .Text)
                    }
                    .padding(.horizontal, 4)
                    .pixelRoundedBorder(cornerRadius: 4, borderColor: selectedTab == row ? .red : .clear)
                }
                .accentColor(.primary)
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(4)
    }
}

struct HomeTab {
    var icon: Image?
    var title: String
}
