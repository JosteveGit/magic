import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/custom_textfield.dart';
import 'package:magic/app/shared/presentation/widgets/magic_app_bar.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const MagicAppBar(title: "Profile"),
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
                      CustomTextField(
                        headerText: "Email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Logout",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
