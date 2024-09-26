import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/modules/workout/presentation/widgets/set_type_image.dart';
import 'package:magic/app/shared/functions/dialog_functions.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class SetItem extends ConsumerWidget {
  final SetModel model;
  final VoidCallback? onTap;
  final VoidCallback? onDismissed;
  const SetItem({
    super.key,
    required this.model,
    this.onTap,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeProvider).colors;
    return Dismissible(
      key: ValueKey(model),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(0),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Delete",
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
      onDismissed: (_) {
        onDismissed?.call();
      },
      confirmDismiss: (_) async {
        bool shouldDelete = false;
        await showReusableDialog(
          context,
          title: "Delete set",
          message: "Are you sure you want to delete this set?",
          onClosed: () {
            shouldDelete = true;
          },
        );
        return shouldDelete;
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 15),
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
              SetTypeImage(setType: model.setType),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.typeName,
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
                          "${model.weight} KG",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: colors.alwaysWhite,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${model.repetitions} reps",
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
        ),
      ),
    );
  }
}
