import 'package:pokedex/domain/entities/pokemon.dart';

abstract class PokemonLocalDatasource {
  Future<List<Pokemon>> getPokemonList(int offset, int limit);
  Future<Pokemon?> getPokemon(String id);

  Future<void> savePokemon(Pokemon pokemon);
  Future<void> savePokemonList(List<Pokemon> pokemons);
  List<Pokemon> searchPokemon(String query);
}
