import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
// import 'package:hive/hive.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/domain/datasource/pokemon_local_datasource.dart';
import 'package:pokedex/domain/datasource/pokemon_remote_datasource.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/domain/repositories/pokemons_repository.dart';

class PokemonsRepositoryImpl extends PokemonsRepository {
  final PokemonRemoteDatasource remoteDataSource;
  final PokemonLocalDatasource localDatasource;

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemonList(
      int offset, int limit) async {
    List<Pokemon> pokemons = [];

    for (int i = offset; i < offset + limit; i++) {
      Pokemon? pokemon;

      // Check if pokemon is in local database
      try {
        pokemon = await localDatasource.getPokemon(i.toString());
        pokemons.add(pokemon!);
        continue;
      } catch (e) {
        debugPrint(e.toString());
      }

      // Get pokemon from remote and save to local
      try {
        pokemon = await remoteDataSource.getPokemon(i.toString());
        pokemons.add(pokemon);
        localDatasource.savePokemon(pokemon);
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    if (pokemons.isEmpty) {
      return Left(Failure(message: 'No pokemons found'));
    }

    return Right(pokemons);
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon(String id) async {
    Pokemon? pokemon;
    // Check if pokemon is in local database
    try {
      pokemon = await localDatasource.getPokemon(id);
      if (pokemon != null) {
        return Right(pokemon);
      }
    } catch (e) {
      debugPrint("localDatasource: $e");
    }

    // Get pokemon from remote and save to local
    try {
      pokemon = await remoteDataSource.getPokemon(id);
      return Right(pokemon);
    } catch (e) {
      debugPrint("remoteDataSourcee: $e");
      if (pokemon != null) {
        return Right(pokemon);
      }
      return Left(Failure(message: e.toString()));
    }
  }

  PokemonsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDatasource,
  });
}
