// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetListQuery: GraphQLQuery {
  public static let operationName: String = "GetList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetList { pokemon_v2_pokemonspecies(order_by: { id: asc }) { __typename id name pokemon_v2_generation { __typename id } } }"#
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
        .field("name", String.self),
        .field("pokemon_v2_generation", Pokemon_v2_generation?.self),
      ] }

      public var id: Int { __data["id"] }
      public var name: String { __data["name"] }
      /// An object relationship
      public var pokemon_v2_generation: Pokemon_v2_generation? { __data["pokemon_v2_generation"] }

      /// Pokemon_v2_pokemonspecy.Pokemon_v2_generation
      ///
      /// Parent Type: `Pokemon_v2_generation`
      public struct Pokemon_v2_generation: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_generation }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
        ] }

        public var id: Int { __data["id"] }
      }
    }
  }
}
