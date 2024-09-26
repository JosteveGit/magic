import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/dashboard/presentation/providers/get_workouts/get_workouts_provider.dart';
import 'package:magic/app/modules/dashboard/presentation/widgets/workout_item.dart';
import 'package:magic/app/modules/profile/presentation/pages/profile_page.dart';
import 'package:magic/app/modules/workout/presentation/pages/workout_page.dart';
import 'package:magic/app/modules/workout/presentation/providers/delete_workout/delete_workout_provider.dart';
import 'package:magic/app/modules/workout/presentation/providers/delete_workout/delete_workout_state.dart';
import 'package:magic/app/shared/extensions/context_extension.dart';
import 'package:magic/app/shared/functions/app_functions.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/loader.dart';
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
  void initState() {
    onInit(
      () {
        getWorkouts();
      },
    );
    super.initState();
  }

  void getWorkouts() {
    final notifier = ref.read(getWorkoutsProvider.notifier);
    notifier.getWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    final topMargin = MediaQuery.of(context).padding.top;
    final workoutsState = ref.watch(getWorkoutsProvider);
    ref.listen(
      deleteWorkoutProvider,
      (prev, next) {
        if (next is DeleteWorkoutStateError) {
          getWorkouts();
          context.showError(next.message);
        }
      },
    );
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      body: workoutsState.when(
        initial: () {
          return const SizedBox();
        },
        loading: () {
          return Loader.small();
        },
        success: (workouts) {
          final totalWeight = workouts.fold<double>(
            0,
            (previousValue, element) => previousValue + element.totalWeight,
          );
          final totalSets = workouts.fold<int>(
            0,
            (previousValue, element) => previousValue + element.totalSets,
          );
          return Column(
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MagicIcon(
                        icon: Icons.person_rounded,
                        onTap: () {
                          pushTo(context, const ProfilePage());
                        },
                      ),
                    ),
                    Text(
                      workouts.length.toString(),
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: colors.secondary,
                      ),
                    ),
                    Text(
                      "Total workouts",
                      style: TextStyle(
                        color: colors.secondary,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fitness_center_rounded,
                          size: 18,
                          color: colors.secondary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "$totalWeight total KG",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: colors.secondary,
                          ),
                        ),
                        Container(
                          width: 5,
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.secondary,
                          ),
                        ),
                        Icon(
                          Icons.sports_gymnastics_rounded,
                          size: 20,
                          color: colors.secondary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "$totalSets total sets",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: colors.secondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
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
                              pushTo(context, const WorkoutPage());
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (workouts.isEmpty) {
                            return Center(
                              child: Text(
                                "No workouts yet",
                                style: TextStyle(
                                  color: colors.alwaysWhite,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                for (final workout in workouts) ...[
                                  Dismissible(
                                    onDismissed: (_) {
                                      final deleteNotifier = ref.read(
                                        deleteWorkoutProvider.notifier,
                                      );
                                      deleteNotifier.deleteWorkout(workout.id);
                                    },
                                    key: ValueKey(workout.id),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: WorkoutItem(workout: workout),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
        error: (message) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: colors.alwaysWhite,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Retry",
                onPressed: getWorkouts,
              ),
            ],
          );
        },
      ),
    );
  }
}
