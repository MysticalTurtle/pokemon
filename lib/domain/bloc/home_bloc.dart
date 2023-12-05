import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/core/enums/sort_by_enum.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/domain/repositories/pokemons_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PokemonsRepository repository;
  int offset = 1;
  int limit = 3;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<HomeFetchPokemons>(
      (event, emit) async {
        if (state is HomeLoading) return;
        emit(HomeLoading());

        var response = await repository.getPokemonList(offset, limit);
        response.fold(
          (l) => emit(HomeFailure()),
          (r) {
            offset = offset + limit;
            emit(HomeFetched(pokemons: state.pokemons + r));
          },
        );

        while (offset < 18) {
          print(offset);
          var response = await repository.getPokemonList(offset, limit);
          response.fold(
            (l) => emit(HomeFailure()),
            (r) {
              offset = offset + limit;
              emit(HomeFetched(pokemons: state.pokemons + r));
            },
          );
        }
      },
    );

    on<HomeSortPokemons>(
      (event, emit) async {
        var pokemons = state.pokemons;
        if (event.sortType == SortBy.name) {
          pokemons.sort((a, b) => a.name.compareTo(b.name));
        } else {
          pokemons.sort((a, b) => a.id.compareTo(b.id));
        }
        emit(HomeFetched(pokemons: pokemons));
      },
    );

    on<HomeSearchPokemon>(
      (event, emit) async {
        var response = await repository.getPokemon(event.id);
        offset = 0;
        response.fold(
          (l) => emit(HomeInitial()),
          (r) => emit(HomeFetched(pokemons: [r])),
        );
      },
    );
  }
}
