import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/modules/workout/presentation/providers/update_workout/update_work_provider.dart';
import 'package:magic/app/modules/workout/presentation/providers/update_workout/update_workout_state.dart';
import 'package:magic/app/shared/domain/repositories/interfaces/workout_repository_interface.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockWorkoutRepository extends Mock
    implements WorkoutRepositoryInterface {}

void main() {
  group('UpdateWorkoutNotifier', () {
    late WorkoutRepositoryInterface repository;
    late UpdateWorkoutNotifier updateWorkoutNotifier;

    setUp(() {
      repository = MockWorkoutRepository();
      updateWorkoutNotifier = UpdateWorkoutNotifier(repo: repository);
    });

    test('successful updateWorkout updates state to UpdateWorkoutState.success',
        () async {
      when(
        () => repository.updateWorkout(
          sets: any(named: 'sets'),
          workoutId: any(named: 'workoutId'),
        ),
      ).thenAnswer(
        (_) async => left(null),
      );

      expectLater(
        updateWorkoutNotifier.stream,
        emitsInOrder([
          const UpdateWorkoutState.loading(),
          const UpdateWorkoutState.success(),
        ]),
      );

      updateWorkoutNotifier.updateWorkout(
        sets: [
          const SetModel(repetitions: 10, weight: 100, setType: SetType.squat)
        ],
        id: 'workout123',
      );
    });

    test('updateWorkout failure updates state to UpdateWorkoutState.error',
        () async {
      const errorMessage = 'Failed to update workout';

      when(
        () => repository.updateWorkout(
          sets: any(named: 'sets'),
          workoutId: any(named: 'workoutId'),
        ),
      ).thenAnswer(
        (_) async => right(
          const FailureResponse(errorMessage),
        ),
      );

      expectLater(
        updateWorkoutNotifier.stream,
        emitsInOrder([
          const UpdateWorkoutState.loading(),
          const UpdateWorkoutState.error(errorMessage),
        ]),
      );

      updateWorkoutNotifier.updateWorkout(
        sets: [
          const SetModel(repetitions: 8, weight: 120, setType: SetType.deadlift)
        ],
        id: 'invalidWorkoutId',
      );
    });
  });
}
