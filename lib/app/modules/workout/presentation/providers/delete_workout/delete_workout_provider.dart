import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/presentation/providers/delete_workout/delete_workout_state.dart';
import 'package:magic/app/shared/domain/repositories/interfaces/workout_repository_interface.dart';
import 'package:magic/app/shared/domain/repositories/workout_repository.dart';

final deleteWorkoutProvider =
    StateNotifierProvider<DeleteWorkoutNotifier, DeleteWorkoutState>((ref) {
  final repo = ref.read(workoutRepositoryProvider);
  return DeleteWorkoutNotifier(repo: repo);
});

class DeleteWorkoutNotifier extends StateNotifier<DeleteWorkoutState> {
  final WorkoutRepositoryInterface repo;
  DeleteWorkoutNotifier({required this.repo})
      : super(const DeleteWorkoutState.initial());

  void deleteWorkout(String id) async {
    state = const DeleteWorkoutState.loading();
    final response = await repo.deleteWorkout(id);
    response.fold(
      (_) => state = const DeleteWorkoutState.success(),
      (error) => state = DeleteWorkoutState.error(error.message),
    );
  }
}
