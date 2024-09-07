// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetMovesQuery: GraphQLQuery {
  public static let operationName: String = "GetMoves"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetMoves($id: Int) { pokemon_v2_pokemon(where: { id: { _eq: $id } }) { __typename pokemon_v2_pokemonmoves(order_by: { id: asc }) { __typename id level move_learn_method_id pokemon_v2_move { __typename id pokemon_v2_movenames(order_by: { language_id: asc }) { __typename language_id name pokemon_v2_language { __typename name id } } } pokemon_v2_versiongroup { __typename id name } } } }"#
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
          .field("move_learn_method_id", Int?.self),
          .field("pokemon_v2_move", Pokemon_v2_move?.self),
          .field("pokemon_v2_versiongroup", Pokemon_v2_versiongroup?.self),
        ] }

        public var id: Int { __data["id"] }
        public var level: Int { __data["level"] }
        public var move_learn_method_id: Int? { __data["move_learn_method_id"] }
        /// An object relationship
        public var pokemon_v2_move: Pokemon_v2_move? { __data["pokemon_v2_move"] }
        /// An object relationship
        public var pokemon_v2_versiongroup: Pokemon_v2_versiongroup? { __data["pokemon_v2_versiongroup"] }

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
            .field("pokemon_v2_movenames", [Pokemon_v2_movename].self, arguments: ["order_by": ["language_id": "asc"]]),
          ] }

          public var id: Int { __data["id"] }
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
              .field("language_id", Int?.self),
              .field("name", String.self),
              .field("pokemon_v2_language", Pokemon_v2_language?.self),
            ] }

            public var language_id: Int? { __data["language_id"] }
            public var name: String { __data["name"] }
            /// An object relationship
            public var pokemon_v2_language: Pokemon_v2_language? { __data["pokemon_v2_language"] }

            /// Pokemon_v2_pokemon.Pokemon_v2_pokemonmofe.Pokemon_v2_move.Pokemon_v2_movename.Pokemon_v2_language
            ///
            /// Parent Type: `Pokemon_v2_language`
            public struct Pokemon_v2_language: SchemaAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_language }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("name", String.self),
                .field("id", Int.self),
              ] }

              public var name: String { __data["name"] }
              public var id: Int { __data["id"] }
            }
          }
        }

        /// Pokemon_v2_pokemon.Pokemon_v2_pokemonmofe.Pokemon_v2_versiongroup
        ///
        /// Parent Type: `Pokemon_v2_versiongroup`
        public struct Pokemon_v2_versiongroup: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_versiongroup }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("name", String.self),
          ] }

          public var id: Int { __data["id"] }
          public var name: String { __data["name"] }
        }
      }
    }
  }
}
