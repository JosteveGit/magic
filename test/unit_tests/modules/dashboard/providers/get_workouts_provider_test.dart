import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/dashboard/presentation/providers/get_workouts/get_workouts_provider.dart';
import 'package:magic/app/modules/dashboard/presentation/providers/get_workouts/get_workouts_state.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';
import 'package:magic/app/shared/domain/repositories/interfaces/workout_repository_interface.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockWorkoutRepository extends Mock
    implements WorkoutRepositoryInterface {}

class FakeStream<T> extends Fake implements Stream<T> {}

void main() {
  group(
    'GetWorkoutsNotifier',
    () {
      late WorkoutRepositoryInterface repository;
      late GetWorkoutsNotifier getWorkoutsNotifier;
      late StreamController<Either<List<WorkoutModel>, FailureResponse>>
          streamController;

      setUp(() {
        repository = MockWorkoutRepository();
        getWorkoutsNotifier = GetWorkoutsNotifier(repo: repository);
        streamController =
            StreamController<Either<List<WorkoutModel>, FailureResponse>>();
        when(
          () => repository.streamWorkouts(),
        ).thenAnswer((_) => streamController.stream);
      });

      tearDown(() {
        streamController.close();
      });

      test(
          'streaming workouts successfully updates state to GetWorkoutsState.success',
          () async {
        final workouts = [
          WorkoutModel(
            id: '1',
            sets: [],
            date: Timestamp.now(),
          ),
        ];

        expectLater(
          getWorkoutsNotifier.stream,
          emitsInOrder([
            const GetWorkoutsState.loading(),
            GetWorkoutsState.success(workouts),
          ]),
        );

        getWorkoutsNotifier.getWorkouts();
        streamController.add(left(workouts));
      });

      test(
        'error in streaming workouts updates state to GetWorkoutsState.error',
        () async {
          const errorMessage = 'Stream error';

          expectLater(
            getWorkoutsNotifier.stream,
            emitsInOrder([
              const GetWorkoutsState.loading(),
              const GetWorkoutsState.error(errorMessage),
            ]),
          );

          getWorkoutsNotifier.getWorkouts();
          streamController.add(right(const FailureResponse(errorMessage)));
        },
      );
    },
  );
}
