import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/presentation/providers/register/register_provider.dart';
import 'package:magic/app/modules/authentication/presentation/providers/register/register_state.dart';
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

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    ref.listen(
      registerProvider,
      (prev, next) {
        if (next is RegisterStateLoading) {
          showLoadingDialog(context);
        }
        if (next is RegisterStateSuccess) {
          pop(context);
          pushToAndClearStack(context, const DashboardPage());
        }
        if (next is RegisterStateError) {
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
                title: "Register",
                hasBackButton: false,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              headerText: "First name",
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.trim();
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomTextField(
                              headerText: "Last name",
                              onChanged: (value) {
                                setState(() {
                                  lastName = value.trim();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                        validator: (value) => isValidEmailAddress(value)
                            ? null
                            : "Please enter a valid email address",
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Password",
                        isPassword: true,
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                        validator: isValidPassword,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Confirm password",
                        isPassword: true,
                        onChanged: (value) {
                          confirmPassword = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value != password) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Register",
                onPressed: () {
                  final notifier = ref.read(registerProvider.notifier);
                  notifier.register(
                    email: email,
                    password: password,
                    firstName: firstName,
                    lastName: lastName,
                    onSuccess: (userModel) {
                      Preferences.setModel(
                        key: PreferencesStrings.userModel,
                        model: userModel,
                      );
                    },
                  );
                },
                validator: () {
                  return isValidEmailAddress(email) &&
                      isValidPassword(password) == null &&
                      password == confirmPassword &&
                      firstName.isNotEmpty &&
                      lastName.isNotEmpty;
                },
              ),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  text: "Already have an account?",
                  style: TextStyle(
                    color: colors.alwaysWhite,
                    fontFamily: "PlusJakartaDisplay",
                  ),
                  children: [
                    TextSpan(
                      text: " Login",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          pop(context);
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
