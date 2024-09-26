import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/presentation/pages/login_page.dart';
import 'package:magic/app/modules/dashboard/presentation/pages/dashboard_page.dart';
import 'package:magic/app/shared/functions/app_functions.dart';
import 'package:magic/app/shared/helpers/classes/preferences/preferences.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';
import 'package:magic/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initalize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.read(appThemeProvider).colors;
    final hasLoggedIn = getUser() != null;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PlusJakartaDisplay',
        colorScheme: ColorScheme.fromSeed(seedColor: colors.primary),
      ),
      home: hasLoggedIn ? const DashboardPage() : const LoginPage(),
    );
  }
}
