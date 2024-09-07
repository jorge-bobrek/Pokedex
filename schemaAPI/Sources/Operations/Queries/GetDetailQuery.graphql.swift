// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetDetailQuery: GraphQLQuery {
  public static let operationName: String = "GetDetail"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetDetail($id: Int) { pokemon_v2_pokemon(where: { id: { _eq: $id } }) { __typename id pokemon_v2_pokemonspecy { __typename gender_rate capture_rate hatch_counter evolution_chain_id pokemon_v2_pokemonspeciesnames { __typename name language_id } pokemon_v2_pokemoncolor { __typename id pokemon_v2_pokemoncolornames { __typename language_id name } } pokemon_v2_growthrate { __typename id name } pokemon_v2_generation { __typename id } } pokemon_v2_pokemonabilities { __typename id is_hidden pokemon_v2_ability { __typename pokemon_v2_abilitynames { __typename name language_id } } } pokemon_v2_pokemontypes { __typename pokemon_v2_type { __typename id pokemon_v2_typenames { __typename name language_id } } } pokemon_v2_pokemoncries { __typename cries(path: "latest") } } }"#
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
        .field("id", Int.self),
        .field("pokemon_v2_pokemonspecy", Pokemon_v2_pokemonspecy?.self),
        .field("pokemon_v2_pokemonabilities", [Pokemon_v2_pokemonability].self),
        .field("pokemon_v2_pokemontypes", [Pokemon_v2_pokemontype].self),
        .field("pokemon_v2_pokemoncries", [Pokemon_v2_pokemoncry].self),
      ] }

      public var id: Int { __data["id"] }
      /// An object relationship
      public var pokemon_v2_pokemonspecy: Pokemon_v2_pokemonspecy? { __data["pokemon_v2_pokemonspecy"] }
      /// An array relationship
      public var pokemon_v2_pokemonabilities: [Pokemon_v2_pokemonability] { __data["pokemon_v2_pokemonabilities"] }
      /// An array relationship
      public var pokemon_v2_pokemontypes: [Pokemon_v2_pokemontype] { __data["pokemon_v2_pokemontypes"] }
      /// An array relationship
      public var pokemon_v2_pokemoncries: [Pokemon_v2_pokemoncry] { __data["pokemon_v2_pokemoncries"] }

      /// Pokemon_v2_pokemon.Pokemon_v2_pokemonspecy
      ///
      /// Parent Type: `Pokemon_v2_pokemonspecies`
      public struct Pokemon_v2_pokemonspecy: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemonspecies }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("gender_rate", Int?.self),
          .field("capture_rate", Int?.self),
          .field("hatch_counter", Int?.self),
          .field("evolution_chain_id", Int?.self),
          .field("pokemon_v2_pokemonspeciesnames", [Pokemon_v2_pokemonspeciesname].self),
          .field("pokemon_v2_pokemoncolor", Pokemon_v2_pokemoncolor?.self),
          .field("pokemon_v2_growthrate", Pokemon_v2_growthrate?.self),
          .field("pokemon_v2_generation", Pokemon_v2_generation?.self),
        ] }

        public var gender_rate: Int? { __data["gender_rate"] }
        public var capture_rate: Int? { __data["capture_rate"] }
        public var hatch_counter: Int? { __data["hatch_counter"] }
        public var evolution_chain_id: Int? { __data["evolution_chain_id"] }
        /// An array relationship
        public var pokemon_v2_pokemonspeciesnames: [Pokemon_v2_pokemonspeciesname] { __data["pokemon_v2_pokemonspeciesnames"] }
        /// An object relationship
        public var pokemon_v2_pokemoncolor: Pokemon_v2_pokemoncolor? { __data["pokemon_v2_pokemoncolor"] }
        /// An object relationship
        public var pokemon_v2_growthrate: Pokemon_v2_growthrate? { __data["pokemon_v2_growthrate"] }
        /// An object relationship
        public var pokemon_v2_generation: Pokemon_v2_generation? { __data["pokemon_v2_generation"] }

        /// Pokemon_v2_pokemon.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonspeciesname
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

        /// Pokemon_v2_pokemon.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemoncolor
        ///
        /// Parent Type: `Pokemon_v2_pokemoncolor`
        public struct Pokemon_v2_pokemoncolor: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemoncolor }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("pokemon_v2_pokemoncolornames", [Pokemon_v2_pokemoncolorname].self),
          ] }

          public var id: Int { __data["id"] }
          /// An array relationship
          public var pokemon_v2_pokemoncolornames: [Pokemon_v2_pokemoncolorname] { __data["pokemon_v2_pokemoncolornames"] }

          /// Pokemon_v2_pokemon.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemoncolor.Pokemon_v2_pokemoncolorname
          ///
          /// Parent Type: `Pokemon_v2_pokemoncolorname`
          public struct Pokemon_v2_pokemoncolorname: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemoncolorname }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("language_id", Int?.self),
              .field("name", String.self),
            ] }

            public var language_id: Int? { __data["language_id"] }
            public var name: String { __data["name"] }
          }
        }

        /// Pokemon_v2_pokemon.Pokemon_v2_pokemonspecy.Pokemon_v2_growthrate
        ///
        /// Parent Type: `Pokemon_v2_growthrate`
        public struct Pokemon_v2_growthrate: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_growthrate }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("name", String.self),
          ] }

          public var id: Int { __data["id"] }
          public var name: String { __data["name"] }
        }

        /// Pokemon_v2_pokemon.Pokemon_v2_pokemonspecy.Pokemon_v2_generation
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

      /// Pokemon_v2_pokemon.Pokemon_v2_pokemonability
      ///
      /// Parent Type: `Pokemon_v2_pokemonability`
      public struct Pokemon_v2_pokemonability: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemonability }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("is_hidden", Bool.self),
          .field("pokemon_v2_ability", Pokemon_v2_ability?.self),
        ] }

        public var id: Int { __data["id"] }
        public var is_hidden: Bool { __data["is_hidden"] }
        /// An object relationship
        public var pokemon_v2_ability: Pokemon_v2_ability? { __data["pokemon_v2_ability"] }

        /// Pokemon_v2_pokemon.Pokemon_v2_pokemonability.Pokemon_v2_ability
        ///
        /// Parent Type: `Pokemon_v2_ability`
        public struct Pokemon_v2_ability: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_ability }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("pokemon_v2_abilitynames", [Pokemon_v2_abilityname].self),
          ] }

          /// An array relationship
          public var pokemon_v2_abilitynames: [Pokemon_v2_abilityname] { __data["pokemon_v2_abilitynames"] }

          /// Pokemon_v2_pokemon.Pokemon_v2_pokemonability.Pokemon_v2_ability.Pokemon_v2_abilityname
          ///
          /// Parent Type: `Pokemon_v2_abilityname`
          public struct Pokemon_v2_abilityname: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_abilityname }
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

      /// Pokemon_v2_pokemon.Pokemon_v2_pokemontype
      ///
      /// Parent Type: `Pokemon_v2_pokemontype`
      public struct Pokemon_v2_pokemontype: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemontype }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("pokemon_v2_type", Pokemon_v2_type?.self),
        ] }

        /// An object relationship
        public var pokemon_v2_type: Pokemon_v2_type? { __data["pokemon_v2_type"] }

        /// Pokemon_v2_pokemon.Pokemon_v2_pokemontype.Pokemon_v2_type
        ///
        /// Parent Type: `Pokemon_v2_type`
        public struct Pokemon_v2_type: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_type }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("pokemon_v2_typenames", [Pokemon_v2_typename].self),
          ] }

          public var id: Int { __data["id"] }
          /// An array relationship
          public var pokemon_v2_typenames: [Pokemon_v2_typename] { __data["pokemon_v2_typenames"] }

          /// Pokemon_v2_pokemon.Pokemon_v2_pokemontype.Pokemon_v2_type.Pokemon_v2_typename
          ///
          /// Parent Type: `Pokemon_v2_typename`
          public struct Pokemon_v2_typename: SchemaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_typename }
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

      /// Pokemon_v2_pokemon.Pokemon_v2_pokemoncry
      ///
      /// Parent Type: `Pokemon_v2_pokemoncries`
      public struct Pokemon_v2_pokemoncry: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Pokemon_v2_pokemoncries }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("cries", SchemaAPI.Jsonb.self, arguments: ["path": "latest"]),
        ] }

        public var cries: SchemaAPI.Jsonb { __data["cries"] }
      }
    }
  }
}
