import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_workout_state.freezed.dart';

@freezed
class UpdateWorkoutState with _$UpdateWorkoutState {
  const factory UpdateWorkoutState.initial() = UpdateWorkoutStateInitial;
  const factory UpdateWorkoutState.loading() = UpdateWorkoutStateLoading;
  const factory UpdateWorkoutState.success() = UpdateWorkoutStateSuccess;
  const factory UpdateWorkoutState.error(String message) = UpdateWorkoutStateError;
}
