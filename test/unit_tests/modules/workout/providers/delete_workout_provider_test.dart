import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/workout/presentation/providers/delete_workout/delete_workout_provider.dart';
import 'package:magic/app/modules/workout/presentation/providers/delete_workout/delete_workout_state.dart';
import 'package:magic/app/shared/domain/repositories/interfaces/workout_repository_interface.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockWorkoutRepository extends Mock
    implements WorkoutRepositoryInterface {}

void main() {
  group('DeleteWorkoutNotifier', () {
    late WorkoutRepositoryInterface repository;
    late DeleteWorkoutNotifier deleteWorkoutNotifier;

    setUp(() {
      repository = MockWorkoutRepository();
      deleteWorkoutNotifier = DeleteWorkoutNotifier(repo: repository);
    });

    test('successful deleteWorkout updates state to DeleteWorkoutState.success',
        () async {
      when(() => repository.deleteWorkout("validWorkoutId")).thenAnswer(
        (_) async => left(
          null,
        ),
      );

      expectLater(
        deleteWorkoutNotifier.stream,
        emitsInOrder([
          const DeleteWorkoutState.loading(),
          const DeleteWorkoutState.success(),
        ]),
      );

      deleteWorkoutNotifier.deleteWorkout('validWorkoutId');
    });

    test('deleteWorkout failure updates state to DeleteWorkoutState.error',
        () async {
      const errorMessage = 'Deletion failed';

      when(() => repository.deleteWorkout("invalidWorkoutId")).thenAnswer(
        (_) async => right(
          const FailureResponse(errorMessage),
        ),
      );

      expectLater(
        deleteWorkoutNotifier.stream,
        emitsInOrder([
          const DeleteWorkoutState.loading(),
          const DeleteWorkoutState.error(errorMessage),
        ]),
      );

      deleteWorkoutNotifier.deleteWorkout('invalidWorkoutId');
    });
  });
}
