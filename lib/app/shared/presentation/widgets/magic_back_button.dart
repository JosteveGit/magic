import 'package:flutter/material.dart';
import 'package:magic/app/shared/presentation/widgets/magic_icon.dart';
import 'package:magic/core/navigation/navigator.dart';

class MagicBackButton extends StatelessWidget {
  const MagicBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MagicIcon(
      icon: Icons.arrow_back_rounded,
      onTap: () {
        pop(context);
      },
    );
  }
}
