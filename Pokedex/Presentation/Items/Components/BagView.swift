//
//  BagView.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 13/02/25.
//

import SwiftUI

struct BagView: View {
    @Binding var selected: ItemPocket
    
    var body: some View {
        Image("Pocket/\(selected)")
            .resizable()
            .frame(width: 70, height: 70)
            .animation(nil, value: selected)
    }
}
