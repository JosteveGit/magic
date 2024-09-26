import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_workout_state.freezed.dart';

@freezed
class EditWorkoutState with _$EditWorkoutState {
  const factory EditWorkoutState.initial() = EditWorkoutStateInitial;
  const factory EditWorkoutState.loading() = EditWorkoutStateLoading;
  const factory EditWorkoutState.success() = EditWorkoutStateSuccess;
  const factory EditWorkoutState.error(String message) = EditWorkoutStateError;
}
