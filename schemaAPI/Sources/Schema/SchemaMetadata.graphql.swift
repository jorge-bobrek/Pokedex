// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SchemaAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SchemaAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "query_root": return SchemaAPI.Objects.Query_root
    case "pokemon_v2_pokemonspecies": return SchemaAPI.Objects.Pokemon_v2_pokemonspecies
    case "pokemon_v2_generation": return SchemaAPI.Objects.Pokemon_v2_generation
    case "pokemon_v2_pokemon": return SchemaAPI.Objects.Pokemon_v2_pokemon
    case "pokemon_v2_pokemonspeciesname": return SchemaAPI.Objects.Pokemon_v2_pokemonspeciesname
    case "pokemon_v2_pokemoncolor": return SchemaAPI.Objects.Pokemon_v2_pokemoncolor
    case "pokemon_v2_pokemoncolorname": return SchemaAPI.Objects.Pokemon_v2_pokemoncolorname
    case "pokemon_v2_growthrate": return SchemaAPI.Objects.Pokemon_v2_growthrate
    case "pokemon_v2_pokemonability": return SchemaAPI.Objects.Pokemon_v2_pokemonability
    case "pokemon_v2_ability": return SchemaAPI.Objects.Pokemon_v2_ability
    case "pokemon_v2_abilityname": return SchemaAPI.Objects.Pokemon_v2_abilityname
    case "pokemon_v2_pokemontype": return SchemaAPI.Objects.Pokemon_v2_pokemontype
    case "pokemon_v2_type": return SchemaAPI.Objects.Pokemon_v2_type
    case "pokemon_v2_typename": return SchemaAPI.Objects.Pokemon_v2_typename
    case "pokemon_v2_pokemoncries": return SchemaAPI.Objects.Pokemon_v2_pokemoncries
    case "pokemon_v2_evolutionchain": return SchemaAPI.Objects.Pokemon_v2_evolutionchain
    case "pokemon_v2_pokemonevolution": return SchemaAPI.Objects.Pokemon_v2_pokemonevolution
    case "pokemon_v2_evolutiontrigger": return SchemaAPI.Objects.Pokemon_v2_evolutiontrigger
    case "pokemon_v2_gender": return SchemaAPI.Objects.Pokemon_v2_gender
    case "pokemon_v2_item": return SchemaAPI.Objects.Pokemon_v2_item
    case "pokemon_v2_location": return SchemaAPI.Objects.Pokemon_v2_location
    case "pokemon_v2_move": return SchemaAPI.Objects.Pokemon_v2_move
    case "pokemon_v2_pokemonmove": return SchemaAPI.Objects.Pokemon_v2_pokemonmove
    case "pokemon_v2_movename": return SchemaAPI.Objects.Pokemon_v2_movename
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
