import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pokedex/core/extensions/string_extension.dart';
import 'package:pokedex/core/theme/app_colors.dart';
import 'package:pokedex/core/theme/app_shadows.dart';
import 'package:pokedex/core/theme/app_text_styles.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/presentation/pokemon_info/pokemon_info_page.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => PokemonInfoPage(
              pokemon: pokemon,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              AppShadows.dropShadow2,
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.03),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        // const FittedBox(
                        Text(
                          "#${pokemon.id.toString().padLeft(3, '0')}",
                          style: AppTextStyles.body3,
                        ),
                        // ),
                        SizedBox(width: constraints.maxHeight * 0.03),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  // SizedBox(height: constraints.maxWidth * 0.1),
                  CachedNetworkImage(
                    imageUrl: pokemon.image,
                    placeholder: (context, _) =>
                        LoadingAnimationWidget.threeArchedCircle(
                      color: AppColors.primary,
                      size: constraints.maxHeight * 0.6,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: constraints.maxHeight * 0.6,
                  ),
                  SizedBox(
                    height: constraints.maxWidth * 0.20,
                    child: Text(
                      pokemon.name.toTitleCase(),
                      style: AppTextStyles.body3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
