import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_porto/homepage/homepage_view.dart';
import 'package:in_porto/onboarding/onboarding_view.dart';
import 'package:in_porto/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("hasSeenOnboarding") ?? false;
  runApp(MainApp(onboarding: onboarding));
}

class MainApp extends StatelessWidget {
  final bool onboarding;

  const MainApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: onboarding ? const HomepageView() : const OnboardingView(),
    );
  }
}
