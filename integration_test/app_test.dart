import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:magic/app/shared/helpers/classes/preferences/preferences.dart';
import 'package:magic/firebase_options.dart';
import 'package:magic/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Preferences.initalize();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  group('end-to-end test', () {
    testWidgets('E2E', (tester) async {
      await Preferences.clear();
      await tester.pumpWidget(const ProviderScope(child: app.MyApp()));
      await tester.pumpAndSettle();

      //Login.
      final emailField = find.byKey(const Key('email'));
      final passwordField = find.byKey(const Key('password'));

      await tester.enterText(emailField, 'adekanbijosteve@gmail.com');
      await tester.pumpAndSettle();
      await tester.enterText(passwordField, '1Josteve1\$');
      await tester.pumpAndSettle();

      final loginButton = find.byKey(const Key('loginButton'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 5));

      expect(find.byKey(const Key('DashboardPage')), findsOneWidget);

      final addWorkoutButton = find.byKey(const Key('addWorkoutButton'));
      await tester.tap(addWorkoutButton);

      await tester.pumpAndSettle();

      final addSetButton = find.byKey(const Key('addSetButton'));
      await tester.tap(addSetButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('SetPage')), findsOneWidget);

      final weightField = find.byKey(const Key('weight'));
      final repetitionsField = find.byKey(const Key('repetitions'));

      await tester.enterText(weightField, '100');
      await tester.pumpAndSettle();

      await tester.enterText(repetitionsField, '10');
      await tester.pumpAndSettle();

      final saveSetButton = find.byKey(const Key('saveSetButton'));
      await tester.tap(saveSetButton);
      await tester.pumpAndSettle();

      final saveWorkoutButton = find.byKey(const Key('saveWorkoutButton'));
      await tester.tap(saveWorkoutButton);
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 5));

      expect(find.byKey(const Key('DashboardPage')), findsOneWidget);

      final profileButton = find.byKey(const Key('profileButton'));
      await tester.tap(profileButton);

      await tester.pumpAndSettle();

      final logoutButton = find.byKey(const Key('logoutButton'));
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 5));
    });
  });
}
