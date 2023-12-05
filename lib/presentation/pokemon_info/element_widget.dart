import 'package:flutter/material.dart';
import 'package:pokedex/core/extensions/name_color.dart';
import 'package:pokedex/core/extensions/string_extension.dart';
import 'package:pokedex/core/theme/app_text_styles.dart';

class ElementWidget extends StatelessWidget {
  const ElementWidget({super.key, required this.element});

  final String element;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: element.mapToColor(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        child: Text(element.toTitleCase(), style: AppTextStyles.subtitle1),
      ),
    );
  }
}
