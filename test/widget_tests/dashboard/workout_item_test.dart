import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/dashboard/presentation/widgets/workout_item.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/modules/workout/presentation/widgets/set_type_image.dart';
import 'package:magic/app/shared/data/models/workout_model.dart';
import 'package:magic/app/shared/functions/string_functions.dart';

void main() {
  group('WorkoutItem Widget Tests', () {
    final testWorkoutModel = WorkoutModel(
      sets: [
        const SetModel(
            setType: SetType.benchPress, weight: 80.0, repetitions: 10),
        const SetModel(setType: SetType.squat, weight: 100.0, repetitions: 5)
      ],
      id: 'workout123',
      date: Timestamp.now(),
    );

    Widget createTestWidget({required Widget child}) {
      return ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: child,
          ),
        ),
      );
    }

    testWidgets('WorkoutItem displays the correct content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
          createTestWidget(child: WorkoutItem(workout: testWorkoutModel)));

      expect(find.text(testWorkoutModel.formattedDate), findsOneWidget);
      expect(find.text('${testWorkoutModel.totalWeight} KG'), findsOneWidget);
      expect(
        find.text(numberSuffixWord(testWorkoutModel.totalSets, "set")),
        findsOneWidget,
      );
      expect(find.byType(Icon), findsNWidgets(3));
      expect(
        find.byType(SetTypeImage),
        findsNWidgets(testWorkoutModel.types.length),
      );
    });
  });
}
