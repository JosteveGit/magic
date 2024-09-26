import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/shared/presentation/widgets/custom_dropdown.dart';

void main() {
  Widget createTestableWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  group('CustomDropDown Widget Tests', () {
    testWidgets(
      'renders correctly with initial item selected',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestableWidget(
            CustomDropDown<String>(
              header: 'Test Header',
              items: const [
                CustomDropDownItem(value: 'item1', text: 'Item 1'),
                CustomDropDownItem(value: 'item2', text: 'Item 2'),
              ],
              onSelected: (_) {},
              value: 'item1',
            ),
          ),
        );

        // Verify that the widget displays the initial item
        expect(find.text('Item 1'), findsOneWidget);
        expect(find.text('Item 2'), findsNothing);
      },
    );

    testWidgets(
      'expands and shows all items when tapped',
      (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          createTestableWidget(
            SafeArea(
              child: Center(
                child: CustomDropDown<String>(
                  header: 'Test Header',
                  items: const [
                    CustomDropDownItem(value: 'item1', text: 'Item 1'),
                    CustomDropDownItem(value: 'item2', text: 'Item 2'),
                  ],
                  onSelected: (_) {},
                  value: 'item1',
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Item 1'));
        await tester.pumpAndSettle();

        expect(find.text('Item 1'), findsOneWidget);
        expect(find.text('Item 2'), findsOneWidget);
      },
    );

    testWidgets('selects a new item when tapped', (
      WidgetTester tester,
    ) async {
      String selectedItem = 'item1';
      await tester.pumpWidget(
        createTestableWidget(
          CustomDropDown<String>(
            header: 'Test Header',
            items: const [
              CustomDropDownItem(value: 'item1', text: 'Item 1'),
              CustomDropDownItem(value: 'item2', text: 'Item 2'),
            ],
            onSelected: (value) {
              selectedItem = value;
            },
            value: selectedItem,
          ),
        ),
      );

      // Expand the dropdown
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle(); // Wait for animations

      // Tap the second item
      await tester.tap(find.text('Item 2'));
      await tester.pumpAndSettle(); // Allow time for state to update

      // Verify that the selectedItem is updated
      expect(selectedItem, 'item2');
    });
  });
}
