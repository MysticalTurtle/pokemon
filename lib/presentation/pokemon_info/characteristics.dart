import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';
import 'package:pokedex/core/theme/app_icons.dart';
import 'package:pokedex/core/theme/app_text_styles.dart';

class Characteristics extends StatelessWidget {
  const Characteristics(
      {super.key,
      required this.weight,
      required this.height,
      required this.moves});

  final String weight;
  final String height;
  final List<String> moves;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Row(
              children: [
                Image.asset(AppIcons.weight, height: 20),
                const SizedBox(width: 10),
                Text("$weight kg", style: AppTextStyles.body1),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Weight", style: AppTextStyles.body1),
          ],
        ),
        Container(
          height: 50,
          width: 1,
          color: AppColors.light,
        ),
        Column(
          children: [
            Row(
              children: [
                Image.asset(AppIcons.straighten, height: 20),
                const SizedBox(width: 10),
                Text("$height m", style: AppTextStyles.body1),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Height", style: AppTextStyles.body1),
          ],
        ),
        Container(
          height: 50,
          width: 1,
          color: AppColors.light,
        ),
        Column(
          children: [
            Text(moves.first, style: AppTextStyles.body1),
            const SizedBox(height: 10),
            Text(moves[1], style: AppTextStyles.body1),
            const SizedBox(height: 10),
            const Text("Moves", style: AppTextStyles.body1),
          ],
        ),
      ],
    );
  }
}
