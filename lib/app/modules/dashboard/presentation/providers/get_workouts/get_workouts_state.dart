import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';

part 'get_workouts_state.freezed.dart';

@freezed
class GetWorkoutsState with _$GetWorkoutsState {
  const factory GetWorkoutsState.initial() = GetWorkoutsStateInitial;
  const factory GetWorkoutsState.loading() = GetWorkoutsStateLoading;
  const factory GetWorkoutsState.success(List<WorkoutModel> workouts) = GetWorkoutsStateSuccess;
  const factory GetWorkoutsState.error(String message) = GetWorkoutsStateError;
}
