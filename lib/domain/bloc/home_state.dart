part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<Pokemon> pokemons;

  const HomeState({this.pokemons = const []});
}

final class HomeInitial extends HomeState {}

final class HomeFetched extends HomeState {
  const HomeFetched({required List<Pokemon> pokemons})
      : super(pokemons: pokemons);
}

final class HomeLoading extends HomeState {
  const HomeLoading({required List<Pokemon> pokemons})
      : super(pokemons: pokemons);
}

final class HomeFailure extends HomeState {}
