import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/modules/workout/presentation/providers/add_workout/create_work_state.dart';
import 'package:magic/app/shared/domain/repositories/interfaces/workout_repository_interface.dart';
import 'package:magic/app/shared/domain/repositories/workout_repository.dart';

final createWorkoutProvider =
    StateNotifierProvider<CreateWorkoutNotifier, CreateWorkoutState>((ref) {
  final repo = ref.read(workoutRepositoryProvider);
  return CreateWorkoutNotifier(repo: repo);
});

class CreateWorkoutNotifier extends StateNotifier<CreateWorkoutState> {
  final WorkoutRepositoryInterface repo;
  CreateWorkoutNotifier({required this.repo})
      : super(const CreateWorkoutState.initial());

  void createWorkout(List<SetModel> sets) async {
    state = const CreateWorkoutState.loading();
    final response = await repo.createWorkout(sets);
    response.fold(
      (_) => state = const CreateWorkoutState.success(),
      (error) => state = CreateWorkoutState.error(error.message),
    );
  }
}
