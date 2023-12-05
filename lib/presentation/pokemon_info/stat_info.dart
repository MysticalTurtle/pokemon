import 'package:flutter/material.dart';
import 'package:pokedex/core/extensions/name_color.dart';
import 'package:pokedex/core/theme/app_colors.dart';
import 'package:pokedex/core/theme/app_text_styles.dart';

class StatInfo extends StatefulWidget {
  const StatInfo({
    super.key,
    required this.text,
    required this.value,
    required this.color,
  });

  final String text;
  final double value;
  final Color color;

  @override
  State<StatInfo> createState() => _StatInfoState();
}

class _StatInfoState extends State<StatInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            widget.text.toStats(),
            textAlign: TextAlign.end,
            style: AppTextStyles.subtitle2.copyWith(
              color: widget.color,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 2,
          height: 20,
          color: AppColors.light,
        ),
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: 0.0,
            end: widget.value,
          ),
          builder: (context, value, _) => Text(
            value.toInt().toString().padLeft(3, '0'),
            style: AppTextStyles.body2,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: 0,
              end: widget.value / 256 > 1 ? 1 : widget.value / 256,
            ),
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              color: widget.color,
              backgroundColor: widget.color.withAlpha(80),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
