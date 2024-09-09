// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetListQuery: GraphQLQuery {
  public static let operationName: String = "GetList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetList { pokemon_v2_pokemonspecies(order_by: { id: asc }) { __typename id generation_id pokemon_v2_pokemonspeciesnames { __typename language_id name } } }"#
    ))

  public init() {}

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Query_root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("pokemon_v2_pokemonspecies", [Pokemon_v2_pokemonspecy].self, arguments: ["order_by": ["id": "asc"]]),
    ] }

    /// An array relationship
    public var pokemon_v2_pokemonspecies: [Pokemon_v2_pokemonspecy] { __data["pokemon_v2_pokemonspecies"] }

    /// Pokemon_v2_pokemonspecy
    ///
    /// Parent Type: `Pokemon_v2_pokemonspecies`
    public struct Pokemon_v2_pokemonspecy: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemonspecies }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("generation_id", Int?.self),
        .field("pokemon_v2_pokemonspeciesnames", [Pokemon_v2_pokemonspeciesname].self),
      ] }

      public var id: Int { __data["id"] }
      public var generation_id: Int? { __data["generation_id"] }
      /// An array relationship
      public var pokemon_v2_pokemonspeciesnames: [Pokemon_v2_pokemonspeciesname] { __data["pokemon_v2_pokemonspeciesnames"] }

      /// Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonspeciesname
      ///
      /// Parent Type: `Pokemon_v2_pokemonspeciesname`
      public struct Pokemon_v2_pokemonspeciesname: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemonspeciesname }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("language_id", Int?.self),
          .field("name", String.self),
        ] }

        public var language_id: Int? { __data["language_id"] }
        public var name: String { __data["name"] }
      }
    }
  }
}
