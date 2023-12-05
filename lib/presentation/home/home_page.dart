import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/theme/app_colors.dart';
import 'package:pokedex/core/theme/app_icons.dart';
import 'package:pokedex/core/theme/app_shadows.dart';
import 'package:pokedex/core/theme/app_text_styles.dart';
import 'package:pokedex/core/widgets/inner_shadow.dart';
import 'package:pokedex/domain/bloc/home_bloc.dart';
import 'package:pokedex/injection_container.dart';

import 'pokemon_item.dart';
import 'search_bar_widget.dart';
import 'sort_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // ADDING THE SCROLL LISTINER
  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print("RUNNING LOAD MORE");
      sl<HomeBloc>().add(HomeFetchPokemons());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(scrollListener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<HomeBloc>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: AppColors.primaryOpacity20,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      AppIcons.pokeballWhite,
                      height: 25,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Pokedex",
                      style: AppTextStyles.headline,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: const Row(
                  children: [
                    Expanded(child: SearchBarWidget()),
                    SizedBox(width: 20),
                    SortIcon(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      AppShadows.dropShadow2,
                    ],
                  ),
                  child: InnerShadow(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 32),
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return GridView(
                            controller: _scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            children: state.pokemons
                                .map(
                                  (pokemon) => PokemonItem(
                                    pokemon: pokemon,
                                    key: UniqueKey(),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
