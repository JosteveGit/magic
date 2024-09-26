import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';
import 'package:magic/app/shared/domain/repositories/workout_repository.dart';
import 'package:magic/app/shared/domain/services/interfaces/workout_service_interface.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockWorkoutService extends Mock implements WorkoutServiceInterface {}

void main() {
  group(
    "WorkoutService",
    () {
      late WorkoutRepository repository;
      late WorkoutServiceInterface service;

      final sets = <SetModel>[
        const SetModel(
          setType: SetType.barbellRow,
          weight: 10,
          repetitions: 10,
        )
      ];

      setUp(
        () {
          service = MockWorkoutService();
          repository = WorkoutRepository(service: service);
        },
      );

      test(
        "createWorkout()",
        () {
          when(
            () => service.createWorkout(sets, "uid"),
          ).thenAnswer(
            (_) async {
              return const Left(null);
            },
          );

          final result = repository.createWorkout(sets, "uid");

          expect(result, isA<Future<void>>());
        },
      );

      test(
        "deleteWorkout()",
        () {
          when(
            () => service.deleteWorkout("workoutId"),
          ).thenAnswer(
            (_) async {
              return const Left(null);
            },
          );

          final result = repository.deleteWorkout("workoutId");

          expect(result, isA<Future<void>>());
        },
      );

      test(
        "updateWorkout()",
        () {
          when(
            () => service.updateWorkout(sets: sets, workoutId: "workoutId"),
          ).thenAnswer(
            (_) async {
              return const Left(null);
            },
          );

          final result = repository.updateWorkout(
            sets: sets,
            workoutId: "workoutId",
          );

          expect(result, isA<Future<void>>());
        },
      );

      test(
        "streamWorkouts()",
        () {
          final model = WorkoutModel(
            sets: sets,
            id: "id",
            date: Timestamp.now(),
          );
          when(
            () => service.streamWorkouts("uid"),
          ).thenAnswer(
            (_) {
              return Stream.value(Left([model]));
            },
          );

          final result = repository.streamWorkouts("uid");

          expect(
            result,
            isA<Stream<Either<List<WorkoutModel>, FailureResponse>>>(),
          );

          result.listen(
            expectAsync1(
              (event) {
                expect(event, isA<Left<List<WorkoutModel>, FailureResponse>>());
              },
            ),
          );
        },
      );
    },
  );
}
