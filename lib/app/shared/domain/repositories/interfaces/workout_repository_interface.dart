import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';

abstract interface class WorkoutRepositoryInterface {
  ApiFuture<void> createWorkout(List<SetModel> sets);
  ApiFuture<void> editWorkout({
    required List<SetModel> sets,
    required String workoutId,
  });
  ApiFuture<void> deleteWorkout(String workoutId);
  ApiStream<List<WorkoutModel>> streamWorkouts(String uid);
}
