// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetEvolutionChainQuery: GraphQLQuery {
  public static let operationName: String = "GetEvolutionChain"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetEvolutionChain($id: Int) { pokemon_v2_evolutionchain(where: { id: { _eq: $id } }) { __typename pokemon_v2_pokemonspecies(order_by: { id: asc }) { __typename id pokemon_v2_pokemonspeciesnames { __typename name language_id } pokemon_v2_pokemonevolutions { __typename pokemon_v2_evolutiontrigger { __typename name } min_affection min_beauty min_happiness min_level needs_overworld_rain party_species_id party_type_id relative_physical_stats time_of_day trade_species_id turn_upside_down pokemon_v2_gender { __typename name } pokemon_v2_item { __typename name } pokemon_v2_location { __typename name } pokemon_v2_move { __typename name } pokemon_v2_type { __typename name } pokemonV2ItemByHeldItemId { __typename name } } } } }"#
    ))

  public var id: GraphQLNullable<Int>

  public init(id: GraphQLNullable<Int>) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Query_root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("pokemon_v2_evolutionchain", [Pokemon_v2_evolutionchain].self, arguments: ["where": ["id": ["_eq": .variable("id")]]]),
    ] }

    /// fetch data from the table: "pokemon_v2_evolutionchain"
    public var pokemon_v2_evolutionchain: [Pokemon_v2_evolutionchain] { __data["pokemon_v2_evolutionchain"] }

    /// Pokemon_v2_evolutionchain
    ///
    /// Parent Type: `Pokemon_v2_evolutionchain`
    public struct Pokemon_v2_evolutionchain: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_evolutionchain }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("pokemon_v2_pokemonspecies", [Pokemon_v2_pokemonspecy].self, arguments: ["order_by": ["id": "asc"]]),
      ] }

      /// An array relationship
      public var pokemon_v2_pokemonspecies: [Pokemon_v2_pokemonspecy] { __data["pokemon_v2_pokemonspecies"] }

      /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy
      ///
      /// Parent Type: `Pokemon_v2_pokemonspecies`
      public struct Pokemon_v2_pokemonspecy: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemonspecies }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("pokemon_v2_pokemonspeciesnames", [Pokemon_v2_pokemonspeciesname].self),
          .field("pokemon_v2_pokemonevolutions", [Pokemon_v2_pokemonevolution].self),
        ] }

        public var id: Int { __data["id"] }
        /// An array relationship
        public var pokemon_v2_pokemonspeciesnames: [Pokemon_v2_pokemonspeciesname] { __data["pokemon_v2_pokemonspeciesnames"] }
        /// An array relationship
        public var pokemon_v2_pokemonevolutions: [Pokemon_v2_pokemonevolution] { __data["pokemon_v2_pokemonevolutions"] }

        /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonspeciesname
        ///
        /// Parent Type: `Pokemon_v2_pokemonspeciesname`
        public struct Pokemon_v2_pokemonspeciesname: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemonspeciesname }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String.self),
            .field("language_id", Int?.self),
          ] }

          public var name: String { __data["name"] }
          public var language_id: Int? { __data["language_id"] }
        }

        /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonevolution
        ///
        /// Parent Type: `Pokemon_v2_pokemonevolution`
        public struct Pokemon_v2_pokemonevolution: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemonevolution }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("pokemon_v2_evolutiontrigger", Pokemon_v2_evolutiontrigger?.self),
            .field("min_affection", Int?.self),
            .field("min_beauty", Int?.self),
            .field("min_happiness", Int?.self),
            .field("min_level", Int?.self),
            .field("needs_overworld_rain", Bool.self),
            .field("party_species_id", Int?.self),
            .field("party_type_id", Int?.self),
            .field("relative_physical_stats", Int?.self),
            .field("time_of_day", String?.self),
            .field("trade_species_id", Int?.self),
            .field("turn_upside_down", Bool.self),
            .field("pokemon_v2_gender", Pokemon_v2_gender?.self),
            .field("pokemon_v2_item", Pokemon_v2_item?.self),
            .field("pokemon_v2_location", Pokemon_v2_location?.self),
            .field("pokemon_v2_move", Pokemon_v2_move?.self),
            .field("pokemon_v2_type", Pokemon_v2_type?.self),
            .field("pokemonV2ItemByHeldItemId", PokemonV2ItemByHeldItemId?.self),
          ] }

          /// An object relationship
          public var pokemon_v2_evolutiontrigger: Pokemon_v2_evolutiontrigger? { __data["pokemon_v2_evolutiontrigger"] }
          public var min_affection: Int? { __data["min_affection"] }
          public var min_beauty: Int? { __data["min_beauty"] }
          public var min_happiness: Int? { __data["min_happiness"] }
          public var min_level: Int? { __data["min_level"] }
          public var needs_overworld_rain: Bool { __data["needs_overworld_rain"] }
          public var party_species_id: Int? { __data["party_species_id"] }
          public var party_type_id: Int? { __data["party_type_id"] }
          public var relative_physical_stats: Int? { __data["relative_physical_stats"] }
          public var time_of_day: String? { __data["time_of_day"] }
          public var trade_species_id: Int? { __data["trade_species_id"] }
          public var turn_upside_down: Bool { __data["turn_upside_down"] }
          /// An object relationship
          public var pokemon_v2_gender: Pokemon_v2_gender? { __data["pokemon_v2_gender"] }
          /// An object relationship
          public var pokemon_v2_item: Pokemon_v2_item? { __data["pokemon_v2_item"] }
          /// An object relationship
          public var pokemon_v2_location: Pokemon_v2_location? { __data["pokemon_v2_location"] }
          /// An object relationship
          public var pokemon_v2_move: Pokemon_v2_move? { __data["pokemon_v2_move"] }
          /// An object relationship
          public var pokemon_v2_type: Pokemon_v2_type? { __data["pokemon_v2_type"] }
          /// An object relationship
          public var pokemonV2ItemByHeldItemId: PokemonV2ItemByHeldItemId? { __data["pokemonV2ItemByHeldItemId"] }

          /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonevolution.Pokemon_v2_evolutiontrigger
          ///
          /// Parent Type: `Pokemon_v2_evolutiontrigger`
          public struct Pokemon_v2_evolutiontrigger: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_evolutiontrigger }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }

          /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonevolution.Pokemon_v2_gender
          ///
          /// Parent Type: `Pokemon_v2_gender`
          public struct Pokemon_v2_gender: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_gender }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }

          /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonevolution.Pokemon_v2_item
          ///
          /// Parent Type: `Pokemon_v2_item`
          public struct Pokemon_v2_item: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_item }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }

          /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonevolution.Pokemon_v2_location
          ///
          /// Parent Type: `Pokemon_v2_location`
          public struct Pokemon_v2_location: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_location }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }

          /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonevolution.Pokemon_v2_move
          ///
          /// Parent Type: `Pokemon_v2_move`
          public struct Pokemon_v2_move: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_move }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }

          /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonevolution.Pokemon_v2_type
          ///
          /// Parent Type: `Pokemon_v2_type`
          public struct Pokemon_v2_type: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_type }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }

          /// Pokemon_v2_evolutionchain.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonevolution.PokemonV2ItemByHeldItemId
          ///
          /// Parent Type: `Pokemon_v2_item`
          public struct PokemonV2ItemByHeldItemId: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_item }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }
        }
      }
    }
  }
}
