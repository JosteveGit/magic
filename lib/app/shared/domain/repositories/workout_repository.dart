import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';
import 'package:magic/app/shared/domain/repositories/interfaces/workout_repository_interface.dart';
import 'package:magic/app/shared/domain/services/interfaces/workout_service_interface.dart';
import 'package:magic/app/shared/domain/services/workout_service.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';

final workoutRepositoryProvider = Provider<WorkoutRepositoryInterface>((ref) {
  final service = ref.watch(workoutServiceProvider);
  return WorkoutRepository(service: service);
});

class WorkoutRepository implements WorkoutRepositoryInterface {
  final WorkoutServiceInterface service;

  WorkoutRepository({required this.service});

  @override
  ApiFuture<void> createWorkout(List<SetModel> sets) {
    return service.createWorkout(sets);
  }

  @override
  ApiFuture<void> deleteWorkout(String workoutId) {
    return service.deleteWorkout(workoutId);
  }

  @override
  ApiFuture<void> editWorkout({
    required List<SetModel> sets,
    required String workoutId,
  }) {
    return service.editWorkout(sets: sets, workoutId: workoutId);
  }

  @override
  ApiStream<List<WorkoutModel>> streamWorkouts(String uid) {
    return service.streamWorkouts(uid);
  }
}
