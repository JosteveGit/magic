import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/presentation/widgets/set_type_image.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';
import 'package:magic/app/shared/functions/string_functions.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class WorkoutItem extends ConsumerWidget {
  final WorkoutModel workout;
  const WorkoutItem({
    super.key,
    required this.workout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeProvider).colors;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: colors.always1d1a20,
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                workout.formattedDate,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: colors.alwaysWhite,
                ),
              ),
              const Spacer(),
              Transform.translate(
                offset: const Offset(10, 0),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: colors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.fitness_center_rounded,
                size: 18,
                color: colors.alwaysWhite,
              ),
              const SizedBox(width: 5),
              Text(
                "${workout.totalWeight} KG",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: colors.alwaysWhite,
                ),
              ),
              Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.alwaysWhite,
                ),
              ),
              Icon(
                Icons.sports_gymnastics_rounded,
                size: 20,
                color: colors.alwaysWhite,
              ),
              const SizedBox(width: 5),
              Text(
                numberSuffixWord(workout.totalSets, "set"),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: colors.alwaysWhite,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (final type in workout.types) SetTypeImage(setType: type),
            ],
          ),
        ],
      ),
    );
  }
}
