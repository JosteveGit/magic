import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/modules/workout/presentation/providers/add_workout/create_work_provider.dart';
import 'package:magic/app/modules/workout/presentation/providers/add_workout/create_work_state.dart';
import 'package:magic/app/shared/domain/repositories/interfaces/workout_repository_interface.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockWorkoutRepository extends Mock
    implements WorkoutRepositoryInterface {}

void main() {
  group('CreateWorkoutNotifier', () {
    late WorkoutRepositoryInterface repository;
    late CreateWorkoutNotifier createWorkoutNotifier;

    setUp(() {
      repository = MockWorkoutRepository();
      createWorkoutNotifier = CreateWorkoutNotifier(repo: repository);
    });

    test('successful createWorkout updates state to CreateWorkoutState.success',
        () async {
      when(() => repository.createWorkout(any())).thenAnswer(
        (_) async => left(
          null,
        ),
      );

      expectLater(
        createWorkoutNotifier.stream,
        emitsInOrder([
          const CreateWorkoutState.loading(),
          const CreateWorkoutState.success(),
        ]),
      );

      createWorkoutNotifier.createWorkout(
        [
          const SetModel(
            repetitions: 8,
            weight: 150,
            setType: SetType.barbellRow,
          )
        ],
      );
    });

    test('createWorkout failure updates state to CreateWorkoutState.error',
        () async {
      const errorMessage = 'Failed to create workout';

      when(() => repository.createWorkout(any())).thenAnswer(
        (_) async => right(
          const FailureResponse(errorMessage),
        ),
      );

      expectLater(
        createWorkoutNotifier.stream,
        emitsInOrder([
          const CreateWorkoutState.loading(),
          const CreateWorkoutState.error(errorMessage),
        ]),
      );

      createWorkoutNotifier.createWorkout(
        [
          const SetModel(
            repetitions: 8,
            weight: 11,
            setType: SetType.benchPress,
          )
        ],
      );
    });
  });
}
