part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeFetchPokemons extends HomeEvent {
  // final int offset;
  // final int limit;

  HomeFetchPokemons();
}

class HomeSortPokemons extends HomeEvent {
  final SortBy sortType;

  HomeSortPokemons({required this.sortType});
}

class HomeSearchPokemon extends HomeEvent {
  final String id;

  HomeSearchPokemon(this.id);
}
