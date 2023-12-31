import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pokedex/core/extensions/name_color.dart';
import 'package:pokedex/core/extensions/string_extension.dart';
import 'package:pokedex/core/theme/app_colors.dart';
import 'package:pokedex/core/theme/app_icons.dart';
import 'package:pokedex/core/theme/app_text_styles.dart';
import 'package:pokedex/core/widgets/inner_shadow.dart';
import 'package:pokedex/domain/bloc/home_bloc.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/presentation/pokemon_info/stat_info.dart';
import 'characteristics.dart';
import 'element_widget.dart';

class PokemonInfoPage extends StatelessWidget {
  const PokemonInfoPage({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(pokemon.name.toTitleCase(), style: AppTextStyles.headline),
            Text(
              "#${pokemon.id.toString().padLeft(3, "0")}",
              style: AppTextStyles.subtitle1,
            ),
          ],
        ),
      ),
      backgroundColor: pokemon.types.first.mapToColor(),
      body: Stack(
        children: [
          // Pokemon Description
          Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top, right: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Image.asset(AppIcons.pokeballOpacity20),
                    ),
                  ),
                ],
              ),
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: InnerShadow(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          // const SingleChildScrollView(
                          // scrollDirection: Axis.horizontal,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              ...pokemon.types
                                  .map((e) => ElementWidget(element: e))
                                  .toList(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "About",
                            style: AppTextStyles.headline.copyWith(
                              color: pokemon.types.first.mapToColor(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Characteristics(
                            weight: pokemon.weight.toDouble().toString(),
                            height: pokemon.height.toDouble().toString(),
                            moves: pokemon.moves,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 0),
                            child: Text(
                              pokemon.description.removeNewLines(),
                              style: AppTextStyles.body1,
                            ),
                          ),
                          Text(
                            "Base Stats",
                            style: AppTextStyles.headline.copyWith(
                              color: pokemon.types.first.mapToColor(),
                            ),
                          ),
                          ...pokemon.stats.map(
                            (e) => StatInfo(
                              text: e.name,
                              value: e.value.toDouble(),
                              color: pokemon.types.first.mapToColor(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Pokemon image
          Positioned(
            top: MediaQuery.of(context).padding.top + 75,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (pokemon.id <= 1) return;
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => PokemonInfoPage(
                              pokemon: context
                                  .read<HomeBloc>()
                                  .state
                                  .pokemons[pokemon.id - 2],
                            ),
                          ),
                        );
                      },
                      child: Image.asset(AppIcons.chevronLeftWhite),
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: pokemon.image,
                    placeholder: (context, _) =>
                        LoadingAnimationWidget.fourRotatingDots(
                      color: AppColors.dark,
                      size: 200,
                    ),
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                    height: MediaQuery.of(context).size.width * 0.6,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      if (context.read<HomeBloc>().state.pokemons.length <=
                          pokemon.id) return;
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => PokemonInfoPage(
                            pokemon: context
                                .read<HomeBloc>()
                                .state
                                .pokemons[pokemon.id],
                          ),
                        ),
                      );
                    },
                    child: Image.asset(AppIcons.chevronRightWhite),
                  )),
                ],
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
