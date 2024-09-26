import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/shared/helpers/classes/media/pngs.dart';
import 'package:magic/app/shared/presentation/widgets/magic_icon.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class SetTypeImage extends ConsumerWidget {
  final SetType setType;
  const SetTypeImage({
    super.key,
    required this.setType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeProvider).colors;
    final imageMap = {
      SetType.barbellRow: Pngs.barbellRow,
      SetType.benchPress: Pngs.benchPress,
      SetType.shoulderPress: Pngs.shoulderPress,
      SetType.deadlift: Pngs.deadlift,
      SetType.squat: Pngs.squat,
    };
    return MagicImage(
      image: imageMap[setType]!,
      color: colors.primary,
      iconColor: colors.secondary,
    );
  }
}