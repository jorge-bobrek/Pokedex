//
//  Network.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/04/24.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://beta.pokeapi.co/graphql/v1beta")!)
}
