import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/dashboard/presentation/pages/dashboard_page.dart';
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
  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
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
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              headerText: "First name",
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: CustomTextField(
                              headerText: "Last name",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      CustomTextField(headerText: "Email"),
                      SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Password",
                        isPassword: true,
                      ),
                      SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Confirm password",
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Register",
                onPressed: () {
                  pushTo(context, const DashboardPage());
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
