import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/presentation/pages/set_page.dart';
import 'package:magic/app/modules/workout/presentation/widgets/set_item.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/magic_app_bar.dart';
import 'package:magic/app/shared/presentation/widgets/magic_icon.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';
import 'package:magic/core/navigation/navigator.dart';

class NewWorkoutPage extends ConsumerStatefulWidget {
  const NewWorkoutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewWorkoutPageState();
}

class _NewWorkoutPageState extends ConsumerState<NewWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MagicAppBar(
                title: "New Workout",
                trailing: [
                  MagicIcon(
                    icon: Icons.add_rounded,
                    onTap: () {
                      pushTo(context, const SetPage());
                    },
                  ),
                ],
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      SetItem(),
                      SizedBox(height: 18),
                      SetItem(),
                      SizedBox(height: 18),
                      SetItem(),
                      SizedBox(height: 18),
                      SetItem(),
                      SizedBox(height: 18),
                      SetItem(),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Save",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
