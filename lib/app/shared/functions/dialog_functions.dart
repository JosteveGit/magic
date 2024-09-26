import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/shared/presentation/widgets/loader.dart';
import 'package:magic/app/shared/presentation/widgets/resuable_dialog.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

void hideKeyBoard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

Future<void> showLoadingDialog(
  BuildContext context,
) {
  hideKeyBoard();
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Loader.small()],
        ),
      );
    },
  );
}

Future<void> showBottomDialog(
  BuildContext context, {
  required Widget child,
  bool setToBottom = true,
  bool barrierDismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return Consumer(
        builder: (context, ref, _) {
          final colors = ref.watch(appThemeProvider).colors;
          return Dialog(
            alignment: setToBottom ? Alignment.bottomCenter : Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            insetPadding: const EdgeInsets.all(16.0),
            backgroundColor: colors.secondary,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [child],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> showReusableDialog(
  BuildContext context, {
  required String title,
  required String message,
  VoidCallback? onClosed,
}) {
  hideKeyBoard();
  return showBottomDialog(
    context,
    barrierDismissible: false,
    child: ResuableDialog(
      title: title,
      message: message,
      onClosed: onClosed,
    ),
  );
}
