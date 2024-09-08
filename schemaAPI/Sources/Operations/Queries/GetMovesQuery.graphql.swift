// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetMovesQuery: GraphQLQuery {
  public static let operationName: String = "GetMoves"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetMoves($id: Int) { pokemon_v2_pokemon(where: { id: { _eq: $id } }) { __typename pokemon_v2_pokemonmoves(order_by: { id: asc }) { __typename id level version_group_id pokemon_v2_move { __typename id power pp accuracy type_id move_damage_class_id pokemon_v2_movenames { __typename name language_id } } } } }"#
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
      .field("pokemon_v2_pokemon", [Pokemon_v2_pokemon].self, arguments: ["where": ["id": ["_eq": .variable("id")]]]),
    ] }

    /// fetch data from the table: "pokemon_v2_pokemon"
    public var pokemon_v2_pokemon: [Pokemon_v2_pokemon] { __data["pokemon_v2_pokemon"] }

    /// Pokemon_v2_pokemon
    ///
    /// Parent Type: `Pokemon_v2_pokemon`
    public struct Pokemon_v2_pokemon: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemon }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("pokemon_v2_pokemonmoves", [Pokemon_v2_pokemonmofe].self, arguments: ["order_by": ["id": "asc"]]),
      ] }

      /// An array relationship
      public var pokemon_v2_pokemonmoves: [Pokemon_v2_pokemonmofe] { __data["pokemon_v2_pokemonmoves"] }

      /// Pokemon_v2_pokemon.Pokemon_v2_pokemonmofe
      ///
      /// Parent Type: `Pokemon_v2_pokemonmove`
      public struct Pokemon_v2_pokemonmofe: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemonmove }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("level", Int.self),
          .field("version_group_id", Int?.self),
          .field("pokemon_v2_move", Pokemon_v2_move?.self),
        ] }

        public var id: Int { __data["id"] }
        public var level: Int { __data["level"] }
        public var version_group_id: Int? { __data["version_group_id"] }
        /// An object relationship
        public var pokemon_v2_move: Pokemon_v2_move? { __data["pokemon_v2_move"] }

        /// Pokemon_v2_pokemon.Pokemon_v2_pokemonmofe.Pokemon_v2_move
        ///
        /// Parent Type: `Pokemon_v2_move`
        public struct Pokemon_v2_move: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_move }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("power", Int?.self),
            .field("pp", Int?.self),
            .field("accuracy", Int?.self),
            .field("type_id", Int?.self),
            .field("move_damage_class_id", Int?.self),
            .field("pokemon_v2_movenames", [Pokemon_v2_movename].self),
          ] }

          public var id: Int { __data["id"] }
          public var power: Int? { __data["power"] }
          public var pp: Int? { __data["pp"] }
          public var accuracy: Int? { __data["accuracy"] }
          public var type_id: Int? { __data["type_id"] }
          public var move_damage_class_id: Int? { __data["move_damage_class_id"] }
          /// An array relationship
          public var pokemon_v2_movenames: [Pokemon_v2_movename] { __data["pokemon_v2_movenames"] }

          /// Pokemon_v2_pokemon.Pokemon_v2_pokemonmofe.Pokemon_v2_move.Pokemon_v2_movename
          ///
          /// Parent Type: `Pokemon_v2_movename`
          public struct Pokemon_v2_movename: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_movename }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String.self),
              .field("language_id", Int?.self),
            ] }

            public var name: String { __data["name"] }
            public var language_id: Int? { __data["language_id"] }
          }
        }
      }
    }
  }
}
