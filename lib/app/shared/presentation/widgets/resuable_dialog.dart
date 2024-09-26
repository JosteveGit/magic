import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/magic_icon.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';
import 'package:magic/core/navigation/navigator.dart';

class ResuableDialog extends ConsumerWidget {
  final String title;
  final String message;
  final VoidCallback? onClosed;
  const ResuableDialog({
    super.key,
    required this.title,
    required this.message,
    this.onClosed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeProvider).colors;
    return Container(
      color: colors.transparent,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          MagicIcon(
            icon: Icons.close,
            color: colors.always26292C,
            onTap: () {
              pop(context);
            },
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: colors.alwaysWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: colors.alwaysWhite,
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Yes",
            onPressed: () {
              pop(context);
              onClosed?.call();
            },
          ),
        ],
      ),
    );
  }
}
