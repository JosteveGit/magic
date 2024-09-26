import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/modules/workout/presentation/providers/update_workout/update_workout_state.dart';
import 'package:magic/app/shared/domain/repositories/interfaces/workout_repository_interface.dart';
import 'package:magic/app/shared/domain/repositories/workout_repository.dart';

final updateWorkoutProvider =
    StateNotifierProvider<UpdateWorkoutNotifier, UpdateWorkoutState>((ref) {
  final repo = ref.read(workoutRepositoryProvider);
  return UpdateWorkoutNotifier(repo: repo);
});

class UpdateWorkoutNotifier extends StateNotifier<UpdateWorkoutState> {
  final WorkoutRepositoryInterface repo;
  UpdateWorkoutNotifier({required this.repo})
      : super(const UpdateWorkoutState.initial());

  void updateWorkout({
    required List<SetModel> sets,
    required String id,
  }) async {
    state = const UpdateWorkoutState.loading();
    final response = await repo.updateWorkout(sets: sets, workoutId: id);
    response.fold(
      (_) => state = const UpdateWorkoutState.success(),
      (error) => state = UpdateWorkoutState.error(error.message),
    );
  }
}
