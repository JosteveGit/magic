import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_work_state.freezed.dart';

@freezed
class AddWorkoutState with _$AddWorkoutState {
  const factory AddWorkoutState.initial() = AddWorkoutStateInitial;
  const factory AddWorkoutState.loading() = AddWorkoutStateLoading;
  const factory AddWorkoutState.success() = AddWorkoutStateSuccess;
  const factory AddWorkoutState.error(String message) = AddWorkoutStateError;
}
