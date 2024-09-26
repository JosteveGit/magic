import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/modules/workout/presentation/pages/set_page.dart';
import 'package:magic/app/modules/workout/presentation/providers/add_workout/create_work_provider.dart';
import 'package:magic/app/modules/workout/presentation/providers/add_workout/create_work_state.dart';
import 'package:magic/app/modules/workout/presentation/providers/update_workout/update_work_provider.dart';
import 'package:magic/app/modules/workout/presentation/providers/update_workout/update_workout_state.dart';
import 'package:magic/app/modules/workout/presentation/widgets/set_item.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';
import 'package:magic/app/shared/extensions/context_extension.dart';
import 'package:magic/app/shared/functions/dialog_functions.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/magic_app_bar.dart';
import 'package:magic/app/shared/presentation/widgets/magic_icon.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';
import 'package:magic/core/navigation/navigator.dart';

class WorkoutPage extends ConsumerStatefulWidget {
  final WorkoutModel? workout;
  const WorkoutPage({
    super.key,
    this.workout,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends ConsumerState<WorkoutPage> {
  final sets = <SetModel>[];

  @override
  void initState() {
    if (widget.workout != null) {
      sets.addAll(widget.workout!.sets);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    ref.listen(
      createWorkoutProvider,
      (prev, next) {
        if (next is CreateWorkoutStateLoading) {
          showLoadingDialog(context);
        }
        if (next is CreateWorkoutStateSuccess) {
          pop(context);
          pop(context);
        }
        if (next is CreateWorkoutStateError) {
          pop(context);
          context.showError(next.message);
        }
      },
    );
    ref.listen(
      updateWorkoutProvider,
      (prev, next) {
        if (next is UpdateWorkoutStateLoading) {
          showLoadingDialog(context);
        }
        if (next is UpdateWorkoutStateSuccess) {
          pop(context);
          pop(context);
          context.showSuccess("Workout updated successfully");
        }
        if (next is UpdateWorkoutStateError) {
          pop(context);
          context.showError(next.message);
        }
      },
    );
    final isUpdate = widget.workout != null;
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MagicAppBar(
                title: isUpdate ? widget.workout!.formattedDate : "New Workout",
                trailing: [
                  MagicIcon(
                    icon: Icons.add_rounded,
                    onTap: () {
                      final page = SetPage(
                        onSave: (set) {
                          sets.add(set);
                          setState(() {});
                        },
                      );
                      pushTo(context, page);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Builder(builder: (context) {
                  if (sets.isEmpty) {
                    return Center(
                      child: Text(
                        "No sets added yet",
                        style: TextStyle(
                          color: colors.alwaysWhite,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                  return ReorderableListView.builder(
                    itemBuilder: (context, index) {
                      final set = sets[index];
                      return SetItem(
                        model: set,
                        key: ValueKey(index),
                        onDismissed: () {
                          sets.removeAt(index);
                          setState(() {});
                        },
                        onTap: () {
                          pushTo(
                            context,
                            SetPage(
                              set: set,
                              onSave: (updatedSet) {
                                sets[index] = updatedSet;
                                setState(() {});
                              },
                            ),
                          );
                        },
                      );
                    },
                    proxyDecorator: (child, index, animation) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (BuildContext context, Widget? child) {
                          final double scale = Tween(begin: 1.0, end: 1.1)
                              .animate(animation)
                              .value;
                          final double rotation = Tween(begin: 0.0, end: -0.1)
                              .animate(animation)
                              .value;
                          final double opacity = Tween(begin: 0.85, end: 1.0)
                              .animate(animation)
                              .value;
                          return Opacity(
                            opacity: opacity,
                            child: Transform.rotate(
                              angle: rotation,
                              child: Transform.scale(
                                scale: scale,
                                child: SetItem(model: sets[index]),
                              ),
                            ),
                          );
                        },
                        child: child,
                      );
                    },
                    itemCount: sets.length,
                    onReorder: (oldIndex, newIndex) {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }

                      final item = sets.removeAt(oldIndex);
                      sets.insert(newIndex, item);
                      setState(() {});
                    },
                  );
                }),
              ),
              CustomButton(
                text: isUpdate ? "Update" : "Save",
                onPressed: () {
                  if (!isUpdate) {
                    final createNotifier = ref.read(
                      createWorkoutProvider.notifier,
                    );
                    createNotifier.createWorkout(sets);
                    return;
                  }
                  final updateNotifier = ref.read(
                    updateWorkoutProvider.notifier,
                  );
                  updateNotifier.updateWorkout(
                    sets: sets,
                    id: widget.workout!.id,
                  );
                },
                validator: () {
                  if (sets.isEmpty) {
                    return false;
                  }
                  if (isUpdate) {
                    final oldSets = widget.workout!.sets;
                    if (sets.length == oldSets.length) {
                      for (var i = 0; i < sets.length; i++) {
                        if (sets[i] != oldSets[i]) {
                          return true;
                        }
                      }
                      return false;
                    }
                  }
                  return true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
