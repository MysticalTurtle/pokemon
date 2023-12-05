import 'package:dartz/dartz.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/domain/entities/pokemon.dart';

abstract class PokemonsRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemonList(int offset, int limit);
  Future<Either<Failure, Pokemon>> getPokemon(String id);

  const PokemonsRepository();
}
