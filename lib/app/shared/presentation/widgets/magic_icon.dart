import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class MagicIcon extends ConsumerWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? iconColor;
  const MagicIcon({
    super.key,
    required this.icon,
    this.color,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeProvider).colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ?? colors.secondary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor ?? colors.alwaysWhite,
          size: 20,
        ),
      ),
    );
  }
}

class MagicImage extends ConsumerWidget {
  final String image;
  final VoidCallback? onTap;
  final Color? color;
  final Color? iconColor;
  const MagicImage({
    super.key,
    required this.image,
    this.color,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeProvider).colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ?? colors.secondary,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          image,
          color: iconColor ?? colors.alwaysWhite,
          width: 25,
        ),
      ),
    );
  }
}
