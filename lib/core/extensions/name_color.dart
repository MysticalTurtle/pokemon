import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

extension NameColor on String {
  Color mapToColor() {
    switch (this) {
      case 'bug':
        return AppColors.bugType;
      case 'dark':
        return AppColors.darkType;
      case 'dragon':
        return AppColors.dragonType;
      case 'electric':
        return AppColors.electricType;
      case 'fairy':
        return AppColors.fairyType;
      case 'fighting':
        return AppColors.fightingType;
      case 'fire':
        return AppColors.fireType;
      case 'flying':
        return AppColors.flyingType;
      case 'ghost':
        return AppColors.ghostType;
      case 'grass':
        return AppColors.grassType;
      case 'ground':
        return AppColors.groundType;
      case 'ice':
        return AppColors.iceType;
      case 'normal':
        return AppColors.normalType;
      case 'poison':
        return AppColors.poisonType;
      case 'psychic':
        return AppColors.psychicType;
      case 'rock':
        return AppColors.rockType;
      case 'steel':
        return AppColors.steelType;
      case 'water':
        return AppColors.waterType;
      default:
        return Colors.black;
    }
  }

  String toTitleCase() {
    return this[0].toUpperCase() + substring(1);
  }

  String toStats() {
    switch (this) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SATK';
      case 'special-defense':
        return 'SDEF';
      case 'speed':
        return 'SPD';
      default:
        return this;
    }
  }
}
