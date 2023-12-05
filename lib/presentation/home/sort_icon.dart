import 'package:flutter/material.dart';
import 'package:pokedex/core/enums/sort_by_enum.dart';
import 'package:pokedex/core/theme/app_colors.dart';
import 'package:pokedex/core/theme/app_icons.dart';
import 'package:pokedex/core/theme/app_text_styles.dart';
import 'package:pokedex/core/widgets/inner_shadow.dart';
import 'package:pokedex/domain/bloc/home_bloc.dart';
import 'package:pokedex/injection_container.dart';

class SortIcon extends StatefulWidget {
  const SortIcon({super.key});

  @override
  State<SortIcon> createState() => _SortIconState();
}

class _SortIconState extends State<SortIcon> {
  bool isMenuOpen = false;
  SortBy selected = SortBy.number;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: Container(
                margin: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Sort by:",
                      style: AppTextStyles.subtitle1,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: 150,
                      height: 120,
                      child: InnerShadow(
                        borderRadius: 20,
                        child: Center(
                          child: Material(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: SortBy.values
                                  .map((e) => _buildSortItem(e))
                                  .toList(),
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
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: InnerShadow(
            borderRadius: 20,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Image.asset(
                selected == SortBy.name
                    ? AppIcons.textFormatRed
                    : AppIcons.tagRed,
                height: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSortItem(SortBy sortBy) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          selected = sortBy;
        });
        Navigator.pop(context);
        sl<HomeBloc>().add(HomeSortPokemons(sortType: sortBy));
      },
      child: Row(
        children: [
          Material(
            child: Radio<SortBy>(
              value: sortBy,
              groupValue: selected,
              onChanged: (_) {},
            ),
          ),
          Text(sortBy.text),
        ],
      ),
    );
  }
}
