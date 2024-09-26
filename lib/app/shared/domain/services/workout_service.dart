import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';
import 'package:magic/app/shared/domain/services/interfaces/workout_service_interface.dart';
import 'package:magic/app/shared/functions/api_functions.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:magic/app/shared/helpers/firebase/firebase_providers.dart';

final workoutServiceProvider = Provider<WorkoutServiceInterface>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return WorkoutService(firestore: firestore);
});

class WorkoutService implements WorkoutServiceInterface {
  final FirebaseFirestore firestore;

  WorkoutService({required this.firestore});
  @override
  ApiFuture<void> createWorkout(List<SetModel> sets, String uid) {
    return futureFunction(
      () async {
        await firestore.collection("workouts").add({
          "sets": sets.map((e) => e.toJson()).toList(),
          "uid": uid,
          "created_at": FieldValue.serverTimestamp(),
        });
      },
    );
  }

  @override
  ApiFuture<void> deleteWorkout(String workoutId) {
    return futureFunction(
      () async {
        await firestore.collection("workouts").doc(workoutId).delete();
      },
    );
  }

  @override
  ApiFuture<void> updateWorkout({
    required List<SetModel> sets,
    required String workoutId,
  }) {
    return futureFunction(
      () async {
        await firestore.collection("workouts").doc(workoutId).update({
          "sets": sets.map((e) => e.toJson()).toList(),
          "updated_at": FieldValue.serverTimestamp(),
        });
      },
    );
  }

  @override
  ApiStream<List<WorkoutModel>> streamWorkouts(String uid) {
    return streamFunction(
      () async* {
        yield* firestore
            .collection("workouts")
            .where("uid", isEqualTo: uid)
            .orderBy("created_at", descending: true)
            .snapshots()
            .map((event) {
          return event.docs
              .map((e) => WorkoutModel.fromJsonAndId(e.data(), e.id))
              .toList();
        });
      },
    );
  }
}
