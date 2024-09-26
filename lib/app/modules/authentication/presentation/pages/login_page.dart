import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/presentation/pages/forgot_password_page.dart';
import 'package:magic/app/modules/authentication/presentation/pages/register_page.dart';
import 'package:magic/app/modules/authentication/presentation/providers/login/login_provider.dart';
import 'package:magic/app/modules/authentication/presentation/providers/login/login_state.dart';
import 'package:magic/app/modules/dashboard/presentation/pages/dashboard_page.dart';
import 'package:magic/app/shared/extensions/context_extension.dart';
import 'package:magic/app/shared/functions/dialog_functions.dart';
import 'package:magic/app/shared/functions/string_functions.dart';
import 'package:magic/app/shared/helpers/classes/preferences/preferences.dart';
import 'package:magic/app/shared/helpers/classes/preferences/preferences_strings.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/custom_textfield.dart';
import 'package:magic/app/shared/presentation/widgets/magic_app_bar.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';
import 'package:magic/core/navigation/navigator.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    ref.listen(
      loginProvider,
      (prev, next) {
        if (next is LoginStateLoading) {
          showLoadingDialog(context);
        }
        if (next is LoginStateSuccess) {
          pop(context);
          pushToAndClearStack(context, const DashboardPage());
        }
        if (next is LoginStateError) {
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
              const MagicAppBar(
                title: "Login",
                hasBackButton: false,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Email",
                        key: const Key("email"),
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
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Password",
                        isPassword: true,
                        key: const Key("password"),
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            pushTo(context, const ForgotPasswordPage());
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: colors.alwaysWhite,
                          ),
                          child: const Text("Forgot password?"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Login",
                key: const Key("loginButton"),
                onPressed: () {
                  final notifier = ref.read(loginProvider.notifier);
                  notifier.login(
                    email: email,
                    password: password,
                    onSuccess: (userModel) {
                      Preferences.setModel(
                        key: PreferencesStrings.userModel,
                        model: userModel,
                      );
                    },
                  );
                },
                validator: () {
                  return isValidEmailAddress(email) && password.isNotEmpty;
                },
              ),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                    color: colors.alwaysWhite,
                    fontFamily: "PlusJakartaDisplay",
                  ),
                  children: [
                    TextSpan(
                      text: " Register",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          pushTo(context, const RegisterPage());
                        },
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
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
