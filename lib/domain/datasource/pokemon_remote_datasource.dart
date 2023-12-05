import 'package:pokedex/domain/entities/pokemon.dart';

abstract class PokemonRemoteDatasource {
  Future<List<Pokemon>> getPokemonList(int offset, int limit);
  Future<Pokemon> getPokemon(String id);
  Future<String> getPokemonDescription(String id);
}
