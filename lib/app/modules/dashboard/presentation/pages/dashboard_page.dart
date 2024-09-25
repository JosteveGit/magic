import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/dashboard/presentation/widgets/workout_item.dart';
import 'package:magic/app/modules/workout/presentation/pages/new_workout_page.dart';
import 'package:magic/app/shared/presentation/widgets/magic_icon.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';
import 'package:magic/core/navigation/navigator.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    final topMargin = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              color: colors.primary,
              padding: EdgeInsets.only(
                top: topMargin,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: MagicIcon(
                      icon: Icons.person_rounded,
                    ),
                  ),
                  const Text(
                    "30",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("Total workouts"),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.fitness_center_rounded,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "30 Total KG",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.alwaysBlack,
                        ),
                      ),
                      const Icon(
                        Icons.sports_gymnastics_rounded,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "30 Total sets",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "My workouts",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colors.alwaysWhite,
                          ),
                        ),
                      ),
                      MagicIcon(
                        icon: Icons.add_rounded,
                        onTap: () {
                          pushTo(context, const NewWorkoutPage());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const WorkoutItem(),
                  const SizedBox(height: 24),
                  const WorkoutItem(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
