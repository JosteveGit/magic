import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class FlatMagicIcon extends ConsumerWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  const FlatMagicIcon({
    super.key,
    required this.icon,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeProvider).colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Icon(
          icon,
          color: iconColor ?? colors.alwaysWhite,
          size: 20,
        ),
      ),
    );
  }
}
