//
//  PokemonNaturesViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/10/24.
//

import Foundation
import SwiftUI

final class PokemonNaturesViewModel: ObservableObject {
    private let natureManager = PokemonNaturesManager()
    
    @Published var natureList = [Nature]()
    
    init() {
        self.natureManager.getPokemonNatures { data in
            self.natureList = data
        }
    }
}

