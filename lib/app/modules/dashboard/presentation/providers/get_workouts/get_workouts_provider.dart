import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/dashboard/presentation/providers/get_workouts/get_workouts_state.dart';
import 'package:magic/app/shared/domain/repositories/interfaces/workout_repository_interface.dart';
import 'package:magic/app/shared/domain/repositories/workout_repository.dart';

final getWorkoutsProvider =
    StateNotifierProvider<GetWorkoutsNotifier, GetWorkoutsState>((ref) {
  final repo = ref.watch(workoutRepositoryProvider);
  return GetWorkoutsNotifier(repo: repo);
});

class GetWorkoutsNotifier extends StateNotifier<GetWorkoutsState> {
  final WorkoutRepositoryInterface repo;
  GetWorkoutsNotifier({required this.repo})
      : super(const GetWorkoutsState.initial());

  StreamSubscription? _streamSubscription;

  void getWorkouts() async {
    state = const GetWorkoutsState.loading();
    _streamSubscription?.cancel();
    _streamSubscription = repo.streamWorkouts().listen(
      (response) {
        response.fold(
          (workouts) => state = GetWorkoutsState.success(workouts),
          (error) => state = GetWorkoutsState.error(error.message),
        );
      },
    );
  }
}
