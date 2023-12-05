import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_icons.dart';
import 'package:pokedex/core/theme/app_text_styles.dart';
import 'package:pokedex/core/widgets/inner_shadow.dart';
import 'package:pokedex/domain/bloc/home_bloc.dart';
import 'package:pokedex/injection_container.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: InnerShadow(
          borderRadius: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 8),
              Image.asset(
                AppIcons.searchRed,
                height: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Center(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    style: AppTextStyles.body1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Search',
                      border: InputBorder.none,
                      hintStyle: AppTextStyles.body1,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    onSubmitted: (value) {
                      sl<HomeBloc>().add(HomeSearchPokemon(value.trim()));
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ),
              controller.text != ''
                  ? IconButton(
                      onPressed: () {
                        controller.clear();
                        focusNode.requestFocus();
                      },
                      icon: Image.asset(AppIcons.closeRed),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
