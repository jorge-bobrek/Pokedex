// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetSpritesQuery: GraphQLQuery {
  public static let operationName: String = "GetSprites"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetSprites { pokemon_v2_pokemonsprites(order_by: { id: asc }) { __typename id sprites(path: "front_default") } }"#
    ))

  public init() {}

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Query_root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("pokemon_v2_pokemonsprites", [Pokemon_v2_pokemonsprite].self, arguments: ["order_by": ["id": "asc"]]),
    ] }

    /// An array relationship
    public var pokemon_v2_pokemonsprites: [Pokemon_v2_pokemonsprite] { __data["pokemon_v2_pokemonsprites"] }

    /// Pokemon_v2_pokemonsprite
    ///
    /// Parent Type: `Pokemon_v2_pokemonsprites`
    public struct Pokemon_v2_pokemonsprite: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemonsprites }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("sprites", SchemaAPI.Jsonb.self, arguments: ["path": "front_default"]),
      ] }

      public var id: Int { __data["id"] }
      public var sprites: SchemaAPI.Jsonb { __data["sprites"] }
    }
  }
}
