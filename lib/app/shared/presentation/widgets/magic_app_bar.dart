import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/shared/presentation/widgets/magic_back_button.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class MagicAppBar extends ConsumerWidget {
  final String title;
  final List<Widget>? trailing;
  const MagicAppBar({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.read(appThemeProvider).colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MagicBackButton(),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: colors.alwaysWhite,
                ),
              ),
            ),
            if (trailing != null) ...trailing!,
          ],
        ),
      ],
    );
  }
}
