import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/presentation/pages/login_page.dart';
import 'package:magic/app/shared/functions/app_functions.dart';
import 'package:magic/app/shared/helpers/classes/preferences/preferences.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/custom_textfield.dart';
import 'package:magic/app/shared/presentation/widgets/magic_app_bar.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';
import 'package:magic/core/navigation/navigator.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    final userModel = getUser()!;
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const MagicAppBar(title: "Profile"),
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
                              readOnly: true,
                              textEditingController: TextEditingController(
                                text: userModel.firstName,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomTextField(
                              headerText: "Last name",
                              readOnly: true,
                              textEditingController: TextEditingController(
                                text: userModel.lastName,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                        textEditingController: TextEditingController(
                          text: userModel.email,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Logout",
                key: const Key("logoutButton"),
                onPressed: () {
                  Preferences.clear();
                  pushToAndClearStack(context, const LoginPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
