import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_workout_state.freezed.dart';

@freezed
class DeleteWorkoutState with _$DeleteWorkoutState {
  const factory DeleteWorkoutState.initial() = DeleteWorkoutStateInitial;
  const factory DeleteWorkoutState.loading() = DeleteWorkoutStateLoading;
  const factory DeleteWorkoutState.success() = DeleteWorkoutStateSuccess;
  const factory DeleteWorkoutState.error(String message) = DeleteWorkoutStateError;
}
