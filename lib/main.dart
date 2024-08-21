import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_porto/screens/home/home_view.dart';
import 'package:in_porto/screens/onboarding/onboarding_view.dart';
import 'package:in_porto/theme.dart';
import 'package:in_porto/notifiers/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("hasSeenOnboarding") ?? false;
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MainApp(onboarding: onboarding)),
  );
}

class MainApp extends StatelessWidget {
  final bool onboarding;

  const MainApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: notifier.themeMode,
          home: onboarding ? const HomeView() : const OnboardingView(),
        );
      },
    );
  }
}
