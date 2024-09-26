import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';

part 'get_workout_state.freezed.dart';

@freezed
class GetWorkoutState with _$GetWorkoutState {
  const factory GetWorkoutState.initial() = GetWorkoutStateInitial;
  const factory GetWorkoutState.loading() = GetWorkoutStateLoading;
  const factory GetWorkoutState.success(List<WorkoutModel> workouts) = GetWorkoutStateSuccess;
  const factory GetWorkoutState.error(String message) = GetWorkoutStateError;
}
