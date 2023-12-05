import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:pokedex/domain/datasource/pokemon_local_datasource.dart';
import 'package:pokedex/domain/entities/pokemon.dart';

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  @override
  List<Pokemon> getPokemonList(int offset, int limit) {
    throw UnimplementedError();
  }

  @override
  Pokemon? getPokemon(String id) {
    var box = Hive.box<String>('pokedex');
    String? pokemonJson = box.get(id);
    if (pokemonJson != null) {
      return Pokemon.fromMap(jsonDecode(pokemonJson));
    }
    return null;
  }

  @override
  void savePokemon(Pokemon pokemon) {
    var box = Hive.box<String>('pokedex');
    box.put(pokemon.id, jsonEncode(pokemon.toMap()));
  }

  @override
  void savePokemonList(List<Pokemon> pokemons) {
    var box = Hive.box<String>('pokedex');
    for (var pokemon in pokemons) {
      box.put(pokemon.id, jsonEncode(pokemon.toMap()));
    }
  }

  @override
  List<Pokemon> searchPokemon(String query) {
    throw UnimplementedError();
  }
}
