import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic/app/shared/presentation/widgets/loader.dart';

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
