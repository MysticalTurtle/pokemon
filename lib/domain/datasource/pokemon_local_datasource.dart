import 'package:pokedex/domain/entities/pokemon.dart';

abstract class PokemonLocalDatasource {
  List<Pokemon> getPokemonList(int offset, int limit);
  Pokemon? getPokemon(String id);

  void savePokemon(Pokemon pokemon);
  void savePokemonList(List<Pokemon> pokemons);
  List<Pokemon> searchPokemon(String query);
}
