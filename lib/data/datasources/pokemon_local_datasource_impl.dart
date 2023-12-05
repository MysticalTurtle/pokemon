import 'dart:convert';

// import 'package:hive/hive.dart';
import 'package:pokedex/domain/datasource/pokemon_local_datasource.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  @override
  Future<List<Pokemon>> getPokemonList(int offset, int limit) {
    throw UnimplementedError();
  }

  @override
  Future<Pokemon?> getPokemon(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? pokemonJson = prefs.getString(id);
    if (pokemonJson != null) {
      return Pokemon.fromMap(jsonDecode(pokemonJson));
    }
    return null;
  }

  @override
  Future<void> savePokemon(Pokemon pokemon) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(pokemon.id.toString(), jsonEncode(pokemon.toMap()));
  }

  @override
  Future<void> savePokemonList(List<Pokemon> pokemons) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var pokemon in pokemons) {
      prefs.setString(pokemon.id.toString(), jsonEncode(pokemon.toMap()));
    }
  }

  @override
  List<Pokemon> searchPokemon(String query) {
    throw UnimplementedError();
  }
}
