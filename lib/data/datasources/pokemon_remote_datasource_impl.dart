import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/domain/datasource/pokemon_remote_datasource.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRemoteDatasourceImpl extends PokemonRemoteDatasource {
  @override
  Future<List<Pokemon>> getPokemonList(int offset, int limit) async {
    List<Pokemon> pokemons = [];

    for (int i = offset; i < offset + limit; i++) {
      try {
        Pokemon pokemon = await getPokemon(i.toString());
        pokemons.add(pokemon);
      } catch (e) {
        continue;
      }
    }

    if (pokemons.isEmpty) throw Failure(message: 'No pokemons found');
    return pokemons;
  }

  @override
  Future<Pokemon> getPokemon(String id) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'),
    );
    PokemonModel? pokemonModel;
    try {
      pokemonModel = PokemonModel.fromJson(jsonDecode(response.body));
      String description = await getPokemonDescription(id);
      pokemonModel.description = description;
      return pokemonModel.toEntity();
    } catch (e) {
      if (pokemonModel != null) {
        return pokemonModel.toEntity();
      }
      throw Failure(message: 'Pokemon not found');
    }
  }

  @override
  Future<String> getPokemonDescription(String id) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$id'),
    );
    return jsonDecode(response.body)['flavor_text_entries'][0]['flavor_text'];
  }
}
