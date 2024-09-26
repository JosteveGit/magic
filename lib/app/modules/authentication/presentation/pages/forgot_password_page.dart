import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/presentation/providers/forgot_password/forgot_password_provider.dart';
import 'package:magic/app/modules/authentication/presentation/providers/forgot_password/forgot_password_state.dart';
import 'package:magic/app/shared/extensions/context_extension.dart';
import 'package:magic/app/shared/functions/dialog_functions.dart';
import 'package:magic/app/shared/functions/string_functions.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/custom_textfield.dart';
import 'package:magic/app/shared/presentation/widgets/magic_app_bar.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';
import 'package:magic/core/navigation/navigator.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<ForgotPasswordPage> {
  String email = "";
  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    ref.listen(
      forgotPasswordProvider,
      (prev, next) {
        if (next is ForgotPasswordStateLoading) {
          showLoadingDialog(context);
        }
        if (next is ForgotPasswordStateSuccess) {
          pop(context);
          context.showSuccess("Please check your email for the reset link");
        }
        if (next is ForgotPasswordStateError) {
          pop(context);
          context.showError(next.message);
        }
      },
    );
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              const MagicAppBar(title: "Forgot Password"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                        validator: (value) {
                          return isValidEmailAddress(value)
                              ? null
                              : "Invalid email address";
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Continue",
                onPressed: () {
                  final notifier = ref.read(forgotPasswordProvider.notifier);
                  notifier.forgotPassword(email: email);
                },
                validator: () {
                  return isValidEmailAddress(email);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
