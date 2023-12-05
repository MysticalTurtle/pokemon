import 'package:get_it/get_it.dart';
import 'package:pokedex/data/datasources/pokemon_local_datasource_impl.dart';
import 'package:pokedex/data/datasources/pokemon_remote_datasource_impl.dart';
import 'package:pokedex/domain/datasource/pokemon_local_datasource.dart';

import 'data/repositories/pokemons_repository_impl.dart';
import 'domain/bloc/home_bloc.dart';
import 'domain/datasource/pokemon_remote_datasource.dart';
import 'domain/repositories/pokemons_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerLazySingleton(() => HomeBloc(repository: sl()));

  // Repository
  sl.registerLazySingleton<PokemonsRepository>(() =>
      PokemonsRepositoryImpl(remoteDataSource: sl(), localDatasource: sl()));

  // Data Source
  sl.registerLazySingleton<PokemonLocalDatasource>(
      () => PokemonLocalDatasourceImpl());

  sl.registerLazySingleton<PokemonRemoteDatasource>(
      () => PokemonRemoteDatasourceImpl());
}
