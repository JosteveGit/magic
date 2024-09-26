import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/modules/workout/presentation/widgets/set_item.dart';

void main() {
  group('SetItem Widget Tests', () {
    const testSetModel = SetModel(
      setType: SetType.benchPress,
      weight: 50.0,
      repetitions: 10,
    );

    Widget createWidgetUnderTest({required SetModel model}) {
      return ProviderScope(
        child: MaterialApp(
          home: SetItem(model: model),
        ),
      );
    }

    testWidgets(
      'SetItem displays the correct content',
      (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createWidgetUnderTest(model: testSetModel));

        expect(find.text('Bench press'), findsOneWidget);
        expect(find.text('50.0 KG'), findsOneWidget);
        expect(find.text('10 reps'), findsOneWidget);
      },
    );

    testWidgets('Tapping SetItem calls onTap callback', (
      WidgetTester tester,
    ) async {
      bool tapCallbackCalled = false;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: SetItem(
              model: testSetModel,
              onTap: () {
                tapCallbackCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SetItem));
      await tester.pumpAndSettle();

      expect(tapCallbackCalled, isTrue);
    });

    testWidgets('Swiping dismisses the SetItem', (
      WidgetTester tester,
    ) async {
      bool dismissCallbackCalled = false;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: SetItem(
              model: testSetModel,
              onDismissed: () {
                dismissCallbackCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.drag(find.byType(Dismissible), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(dismissCallbackCalled, isTrue);
    });
  });
}
