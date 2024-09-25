import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/shared/helpers/classes/media/pngs.dart';
import 'package:magic/app/shared/presentation/widgets/magic_icon.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class SetItem extends ConsumerWidget {
  const SetItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeProvider).colors;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: colors.always1d1a20,
        borderRadius: BorderRadius.circular(23),
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          MagicImage(
            image: Pngs.deadlift,
            color: colors.primary,
            iconColor: colors.secondary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bench Press",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colors.alwaysWhite,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.fitness_center_rounded,
                      size: 12,
                      color: colors.alwaysWhite,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "100kg",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: colors.alwaysWhite,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "10 reps",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
