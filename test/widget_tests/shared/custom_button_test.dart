import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';

void main() {
  group(
    "CustomButton",
    () {
      Widget makeTestableWidget({required Widget child}) {
        return ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: child,
            ),
          ),
        );
      }

      testWidgets('CustomButton displays the text', (
        WidgetTester tester,
      ) async {
        const buttonText = 'Test Button';
        await tester.pumpWidget(
          makeTestableWidget(
            child: CustomButton(
              text: buttonText,
              onPressed: () {},
            ),
          ),
        );

        expect(find.text(buttonText), findsOneWidget);
      });

      testWidgets('CustomButton is disabled when validator returns false', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(makeTestableWidget(
          child: CustomButton(
            text: 'Disabled Button',
            onPressed: () {},
            validator: () => false,
          ),
        ));

        final ElevatedButton button = tester.widget(
          find.byType(ElevatedButton),
        );
        expect(button.onPressed, isNull);
      });

      testWidgets('CustomButton changes color when disabled', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(makeTestableWidget(
          child: CustomButton(
            text: 'Test Button',
            onPressed: () {},
            color: Colors.blue,
            validator: () => false,
          ),
        ));

        final ElevatedButton button =
            tester.widget(find.byType(ElevatedButton));
        final ButtonStyle buttonStyle = button.style!;
        final Color backgroundColor =
            buttonStyle.backgroundColor!.resolve({WidgetState.disabled})!;
        expect(
          backgroundColor,
          equals(
            Colors.blue.withOpacity(0.5),
          ),
        );
      });

      testWidgets('CustomButton onPressed callback is called when tapped', (
        WidgetTester tester,
      ) async {
        bool wasPressed = false;
        await tester.pumpWidget(makeTestableWidget(
          child: CustomButton(
            text: 'Clickable Button',
            onPressed: () {
              wasPressed = true;
            },
          ),
        ));

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
        expect(wasPressed, isTrue);
      });
    },
  );
}
