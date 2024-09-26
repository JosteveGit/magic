import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_work_state.freezed.dart';

@freezed
class CreateWorkoutState with _$CreateWorkoutState {
  const factory CreateWorkoutState.initial() = CreateWorkoutStateInitial;
  const factory CreateWorkoutState.loading() = CreateWorkoutStateLoading;
  const factory CreateWorkoutState.success() = CreateWorkoutStateSuccess;
  const factory CreateWorkoutState.error(String message) = CreateWorkoutStateError;
}
