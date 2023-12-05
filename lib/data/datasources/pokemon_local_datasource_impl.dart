import 'package:pokedex/domain/datasource/pokemon_local_datasource.dart';
import 'package:pokedex/domain/entities/pokemon.dart';

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  @override
  Future<List<Pokemon>> getPokemonList(int offset, int limit) {
    throw UnimplementedError();
  }

  @override
  Future<Pokemon> getPokemon(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> savePokemon(Pokemon pokemon) {
    throw UnimplementedError();
  }

  @override
  Future<void> savePokemonList(List<Pokemon> pokemons) {
    throw UnimplementedError();
  }
}
