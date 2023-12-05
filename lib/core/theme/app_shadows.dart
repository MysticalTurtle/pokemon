import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class AppShadows {
  static const BoxShadow dropShadow2 = BoxShadow(
    color: AppColors.blackAlpha20,
    blurRadius: 2,
    spreadRadius: 2,
  );
  static const BoxShadow dropShadow6 = BoxShadow(
    color: AppColors.medium,
    blurRadius: 2,
    spreadRadius: 0,
  );

  //* Inner shadows is in widgets folder
  static const BoxShadow innerShadow2 = BoxShadow(
    color: Colors.black12,
    offset: Offset(0, 2),
    blurRadius: 12,
    spreadRadius: 3,
  );
}
